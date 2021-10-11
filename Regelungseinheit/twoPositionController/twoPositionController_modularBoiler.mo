within Regelungseinheit.twoPositionController;
model twoPositionController_modularBoiler

parameter Modelica.SIunits.Temperature T_ref=273.15+60 "Solltemperatur";
 parameter Real bandwidth=0 "Bandbreite"; //bandwidth=Abgrenzung nach unten und oben, z.B; bandwidth=2 58,60,62
 parameter Boolean use_BufferStorage=false;
 parameter  Modelica.SIunits.TemperatureDifference TDiff_HK=8 "Differenz zwischen Vorlauftemperatur des Kessels und TTop";
 parameter Integer n=3 "Number of layers in the buffer storage";

 Modelica.Blocks.Logical.Switch switch1
   annotation (Placement(transformation(extent={{34,24},{54,44}})));
 Modelica.Blocks.Sources.RealExpression realZero
   annotation (Placement(transformation(extent={{-102,-70},{-82,-50}})));
 Modelica.Blocks.Interfaces.RealInput PLR_ein
   annotation (Placement(transformation(extent={{-120,70},{-80,110}})));
 Modelica.Blocks.Interfaces.RealOutput PLR_aus
   annotation (Placement(transformation(extent={{90,24},{110,44}})));

 Modelica.Blocks.Interfaces.RealInput TLayers[n]
    "Input temperatures of the different layers of the buffer storage"
    annotation (Placement(transformation(extent={{-120,18},{-80,58}})));
 replaceable BaseClass.twoPositionControllerCal.twoPositionController_layers twoPositionController(layerCal=
        layerCal)
   constrainedby
    Regelungseinheit.twoPositionController.BaseClass.partialTwoPositionController
   annotation (Placement(transformation(extent={{-52,22},{-32,42}})),
     choicesAllMatching=true);
  Modelica.Blocks.Interfaces.RealInput TTop
    annotation (Placement(transformation(extent={{-118,-28},{-78,12}})));
  parameter Boolean layerCal=true
    "If true, the two-position controller uses the mean temperature of the buffer storage";
equation
  //BufferStorage

 connect(switch1.y, PLR_aus)
   annotation (Line(points={{55,34},{100,34}}, color={0,0,127}));
 connect(realZero.y, switch1.u3) annotation (Line(points={{-81,-60},{26,-60},{26,
          26},{32,26}},color={0,0,127}));
 connect(PLR_ein, switch1.u1) annotation (Line(points={{-100,90},{24,90},{24,42},
         {32,42}},     color={0,0,127}));

  connect(twoPositionController.y, switch1.u2) annotation (Line(points={{-32,35.2},
          {0,35.2},{0,34},{32,34}}, color={255,0,255}));
  if layerCal then
    connect(TLayers, twoPositionController.TLayers);
  else
    connect(TTop, twoPositionController.TTop);
  end if;
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
       coordinateSystem(preserveAspectRatio=false)));
end twoPositionController_modularBoiler;
