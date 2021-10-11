within ControlUnity.twoPositionController;
model twoPositionControllerAdvanced
  //
  parameter Boolean use_BufferStorage "If true, use two position controller combined with a buffer storage with n layers";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end twoPositionControllerAdvanced;
