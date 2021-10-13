within ControlUnity.twoPositionController;
model twoPositionControllerBufferStorage_modularBoiler
 //parameter
 parameter Modelica.SIunits.Temperature T_ref=273.15+60 "Solltemperatur";
 parameter Real bandwidth=0 "Bandbreite"; //bandwidth=Abgrenzung nach unten und oben, z.B; bandwidth=2 58,60,62
 parameter  Modelica.SIunits.TemperatureDifference TDiff_HK=8 "Differenz zwischen Vorlauftemperatur des Kessels und TTop";
 parameter Integer n "Number of layers in the buffer storage";
 parameter Boolean layerCal=true
    "If true, the two-position controller uses the mean temperature of the buffer storage";

 Modelica.Blocks.Interfaces.RealOutput PLRset
    annotation (Placement(transformation(extent={{90,24},{110,44}})));

 Modelica.Blocks.Interfaces.RealInput TLayers[n]
    "Input temperatures of the different layers of the buffer storage"
    annotation (Placement(transformation(extent={{-120,-12},{-80,28}})));

  replaceable BaseClass.twoPositionControllerCal.twoPositionController_layers twoPositionController(n=n)
    constrainedby
    ControlUnity.twoPositionController.BaseClass.partialTwoPositionController
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})),choices(
    choice(redeclare BaseClass.twoPositionControllerCal.twoPositionController_layers twoPositionController = ControlUnity.twoPositionController.BaseClass.twoPositionControllerCal.twoPositionController_layers "Calculation with mean temperature"),
    choice(redeclare BaseClass.twoPositionControllerCal.twoPositionController_layers twoPositionController = ControlUnity.twoPositionController.BaseClass.twoPositionControllerCal.twoPositionController_top "Calculation with top level temperature")));
  Modelica.Blocks.Interfaces.RealInput PLRin
    annotation (Placement(transformation(extent={{-120,52},{-80,92}})));
equation
  //BufferStorage


    connect(TLayers, twoPositionController.TLayers);



  connect(twoPositionController.PLRset, PLRset) annotation (Line(points={{-19,35.2},
          {37.5,35.2},{37.5,34},{100,34}}, color={0,0,127}));
  connect(PLRin, twoPositionController.PLRin) annotation (Line(points={{-100,72},
          {-72,72},{-72,39},{-40,39}}, color={0,0,127}));
  connect(TLayers, twoPositionController.TLayers) annotation (Line(points={{-100,
          8},{-72,8},{-72,33.6},{-40,33.6}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
       coordinateSystem(preserveAspectRatio=false)));
end twoPositionControllerBufferStorage_modularBoiler;
