//
//  Camera.swift
//  Camera
//
//  Created by Jageloo Yadav : Digital Office on 8/29/19.
//
//
import AVFoundation
import UIKit

public class Camera: NSObject {
    private var captureSession: AVCaptureSession?
    
    public var currentCameraPosition: CameraPosition?
    
    private var frontCamera: AVCaptureDevice?
    private var frontCameraInput: AVCaptureDeviceInput?
    
    private var photoOutput: AVCapturePhotoOutput?
    
    private var rearCamera: AVCaptureDevice?
    private var rearCameraInput: AVCaptureDeviceInput?
    
    //Audio setting
    private var audioDevice: AVCaptureDevice?
    private var audioDeviceInput: AVCaptureDeviceInput?
    
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    private var flashMode = AVCaptureDevice.FlashMode.off
    private var photoCaptureCompletionBlock: ((UIImage?, Error?) -> Void)?
    
    public var audioRecordingCompletionBlock:((Bool) -> Void)?
    
    public var isOnlyAudioRecord: Bool = false
    
    var fileLocation: String?

}

extension Camera {
    
    public func prepare(audioFileLocation: String? = nil, completionHandler: ((Error?) -> Void)?) {
        self.fileLocation = audioFileLocation
        func createCaptureSession() {
            self.captureSession = AVCaptureSession()
        }
        
        func configureCaptureDevices() throws {
            self.frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                       for: .video,
                                                       position: .front)
            
            self.rearCamera = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                      for: .video,
                                                      position: .back)
        }
        
        func configureAudio() throws {
            self.audioDevice = AVCaptureDevice.default(for: .audio)
            guard let audioDevice = self.audioDevice, let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
            self.audioDeviceInput = try? AVCaptureDeviceInput(device: audioDevice)
            if let audioInput = self.audioDeviceInput {
                captureSession.addInput(audioInput)
                let output = AVCaptureAudioDataOutput()
                output.setSampleBufferDelegate(self, queue: DispatchQueue.main)
                captureSession.addOutput(output)
                captureSession.startRunning()
            }
        }
        
        func configureDeviceInputs() throws {
            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
            
            if let rearCamera = self.rearCamera {
                self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
                
                if captureSession.canAddInput(self.rearCameraInput!) { captureSession.addInput(self.rearCameraInput!) }
                
                self.currentCameraPosition = .rear
            }
                
            else if let frontCamera = self.frontCamera {
                self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
                
                if captureSession.canAddInput(self.frontCameraInput!) { captureSession.addInput(self.frontCameraInput!) }
                else { throw CameraControllerError.inputsAreInvalid }
                
                self.currentCameraPosition = .front
            }
                
            else { throw CameraControllerError.noCamerasAvailable }
        }
        
        func configurePhotoOutput() throws {
            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
            
            self.photoOutput = AVCapturePhotoOutput()
            self.photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            
            if captureSession.canAddOutput(self.photoOutput!) { captureSession.addOutput(self.photoOutput!) }
            captureSession.startRunning()
        }
        
        func createAssetWriter() {
            guard let audioURL = self.fileLocation else { return }
            
        }
        
        func prepare() {
            DispatchQueue(label: "prepare").async {
                do {
                    createCaptureSession()
                    if self.isOnlyAudioRecord {
                        try configureAudio()
                    } else {
                        try configureCaptureDevices()
                        try configureDeviceInputs()
                        try configurePhotoOutput()
                    }
                }
                    
                catch {
                    DispatchQueue.main.async {
                        completionHandler?(error)
                    }
                    
                    return
                }
                
                DispatchQueue.main.async {
                    completionHandler?(nil)
                }
            }
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                if response {
                    prepare()
                } else {
                    DispatchQueue.main.async {
                        completionHandler?(CameraControllerError.cameraAccessRestricted)
                    }
                }
            }
        case .authorized:
            prepare()
        default:
            DispatchQueue.main.async {
                completionHandler?(CameraControllerError.cameraAccessRestricted)
            }
        }
    }
    
    public func displayPreview(on view: UIView) throws {
        guard let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = .portrait
        
        view.layer.insertSublayer(self.previewLayer!, at: 0)
        self.previewLayer?.frame = CGRect.init(x: 0, y: 0, width: 130, height: 130)
    }
    
    public func switchCameras() throws {
        guard let currentCameraPosition = currentCameraPosition, let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }
        
        captureSession.beginConfiguration()
        
        switch currentCameraPosition {
        case .front:
            try switchToRearCamera()
            
        case .rear:
            try switchToFrontCamera()
        }
        
        captureSession.commitConfiguration()
    }
    
    public func switchToFrontCamera() throws {
        guard let captureSession = self.captureSession else { return }
        guard let rearCameraInput = self.rearCameraInput, captureSession.inputs.contains(rearCameraInput),
            let frontCamera = self.frontCamera else { throw CameraControllerError.invalidOperation }
        
        self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
        
        captureSession.removeInput(rearCameraInput)
        
        if captureSession.canAddInput(self.frontCameraInput!) {
            captureSession.addInput(self.frontCameraInput!)
            
            self.currentCameraPosition = .front
        }
            
        else {
            throw CameraControllerError.invalidOperation
        }
    }
    
    public func switchToRearCamera() throws {
        guard let captureSession = self.captureSession else { return }
        guard let frontCameraInput = self.frontCameraInput, captureSession.inputs.contains(frontCameraInput),
            let rearCamera = self.rearCamera else { throw CameraControllerError.invalidOperation }
        
        self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
        
        captureSession.removeInput(frontCameraInput)
        
        if captureSession.canAddInput(self.rearCameraInput!) {
            captureSession.addInput(self.rearCameraInput!)
            
            self.currentCameraPosition = .rear
        }
            
        else { throw CameraControllerError.invalidOperation }
    }

    
    public func captureImage(completion: @escaping (UIImage?, Error?) -> Void) {
        guard let captureSession = captureSession, captureSession.isRunning else { completion(nil, CameraControllerError.captureSessionIsMissing); return }
        
        let settings = AVCapturePhotoSettings()
        settings.flashMode = self.flashMode
        
        self.photoOutput?.capturePhoto(with: settings, delegate: self)
        self.photoCaptureCompletionBlock = completion
    }
    
    public func stopAllTasks() {
        self.captureSession?.stopRunning()
    }

    private func completion(success: Bool) {
        self.audioRecordingCompletionBlock?(success)
        self.captureSession?.stopRunning()
    }
}

extension Camera: AVCapturePhotoCaptureDelegate {
    public func photoOutput(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                        resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Swift.Error?) {
        if let error = error { self.photoCaptureCompletionBlock?(nil, error) }
            
        else if let buffer = photoSampleBuffer, let data =  AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: buffer, previewPhotoSampleBuffer: nil),
            let image = UIImage(data: data) {
            
            self.photoCaptureCompletionBlock?(image, nil)
        }
            
        else {
            self.photoCaptureCompletionBlock?(nil, CameraControllerError.unknown)
        }
    }
}

extension Camera: AVCaptureAudioDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        var buffer: CMBlockBuffer? = nil
        
        // Needs to be initialized somehow, even if we take only the address
        let convenianceBuffer = AudioBuffer(mNumberChannels: 1, mDataByteSize: 0, mData: nil)
        var audioBufferList = AudioBufferList(mNumberBuffers: 1,
                                              mBuffers: convenianceBuffer)
        
        CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer(
            sampleBuffer,
            bufferListSizeNeededOut: nil,
            bufferListOut: &audioBufferList,
            bufferListSize: MemoryLayout<AudioBufferList>.size(ofValue: audioBufferList),
            blockBufferAllocator: nil,
            blockBufferMemoryAllocator: nil,
            flags: UInt32(kCMSampleBufferFlag_AudioBufferList_Assure16ByteAlignment),
            blockBufferOut: &buffer
        )
        
        let abl = UnsafeMutableAudioBufferListPointer(&audioBufferList)
        
        for buffer in abl {
            let originRawPtr = buffer.mData
            let ptrDataSize = Int(buffer.mDataByteSize)
            
            // From raw pointer to typed Int16 pointer
            let buffPtrInt16 = originRawPtr?.bindMemory(to: Int16.self, capacity: ptrDataSize)
            
            // From pointer typed Int16 to pointer of [Int16]
            // So we can iterate on it simply
            let unsafePtrByteSize = ptrDataSize/Int16.bitWidth
            let samples = UnsafeMutableBufferPointer<Int16>(start: buffPtrInt16,
                                                            count: unsafePtrByteSize)
            
            // Average of each sample squared, then root squared
            let sumOfSquaredSamples = samples.map(Float.init).reduce(0) { $0 + $1*$1 }
            let averageOfSomething = sqrt(sumOfSquaredSamples / Float(samples.count))
            
            DispatchQueue.main.async {
                if averageOfSomething > 10000.0 {
                    self.completion(success: true)
                }
            }
        }
    }
}
public extension Camera {
    enum CameraControllerError: Swift.Error {
        case captureSessionAlreadyRunning
        case captureSessionIsMissing
        case inputsAreInvalid
        case invalidOperation
        case noCamerasAvailable
        case cameraAccessRestricted
        case unknown
    }
    
    enum CameraPosition {
        case front
        case rear
    }
}
