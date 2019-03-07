within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
class EngineHousing0901 "Engine housing as a simple two layer wall."
  import AixLib;

  replaceable package Medium3 =
      DataBase.CHP.ModularCHPEngineMedia.CHPFlueGasLambdaOnePlus
                                                           constrainedby
    DataBase.CHP.ModularCHPEngineMedia.CHPCombustionMixtureGasNasa
                                 annotation(choicesAllMatching=true);

  parameter Modelica.SIunits.Thickness dInn=0.005
    "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
    annotation (Dialog(tab="Calibration properties"));

  parameter AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterialData
    EngMatData=AixLib.Fluid.BoilerCHP.Data.ModularCHP.EngineMaterial_CastIron()
    "Thermal engine material data for calculations (most common is cast iron)"
    annotation (choicesAllMatching=true, Dialog(tab="Structure", group=
          "Material Properties"));

  parameter Modelica.SIunits.ThermalConductivity lambda=EngMatData.lambda
    "Thermal conductivity of the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.SIunits.Density rhoEngWall=EngMatData.rhoEngWall
    "Density of the the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.SIunits.SpecificHeatCapacity c=EngMatData.c
    "Specific heat capacity of the cylinder wall material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Real z
    "Number of engine cylinders"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Thickness dCyl
    "Engine cylinder diameter"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Thickness hStr
    "Engine stroke"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Real eps
    "Engine compression ratio"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Mass mEng
    "Total engine mass"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  Real nEng
    "Current engine speed"
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.ThermalConductance GEngToAmb=0.23
    "Thermal conductance from engine housing to the surrounding air"
   annotation (Dialog(tab="Thermal"));
  parameter Modelica.SIunits.Temperature T_Amb=298.15
    "Ambient temperature"
    annotation (Dialog(tab="Thermal"));

protected
  parameter Modelica.SIunits.Area A_WInn=z*(Modelica.Constants.pi*dCyl*(dCyl/2 + hStr*(1 + 1/(eps - 1))))
    "Area of heat transporting surface from cylinder wall to outer engine block"
    annotation (Dialog(tab="Structure"));
  parameter Modelica.SIunits.Mass mEngWall=A_WInn*rhoEngWall*dInn
    "Calculated mass of cylinder wall between combustion chamber and cooling circle"
    annotation (Dialog(tab="Structure"));
  parameter Modelica.SIunits.Mass mEngBlo=mEng - mEngWall
    "Calculated mass of the remaining engine body"
    annotation (Dialog(tab="Structure"));
  parameter Modelica.SIunits.Thickness dOut=mEngBlo/A_WInn/rhoEngWall
    "Thickness of outer wall of the remaining engine body"
    annotation (Dialog(tab="Structure"));
  parameter Modelica.SIunits.HeatCapacity CEngWall=dInn*A_WInn*rhoEngWall*c
    "Heat capacity of cylinder wall between combustion chamber and cooling circle"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.SIunits.HeatCapacity CEngBlo=dOut*A_WInn*rhoEngWall*c
    "Heat capacity of the remaining engine body"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GInnWall=lambda*A_WInn/dInn
   "Thermal conductance of the inner engine wall"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GEngBlo=lambda*A_WInn/dOut
   "Thermal conductance of the remaining engine body"
   annotation (Dialog(tab="Thermal"));

public
  Modelica.SIunits.Temperature T_Com
    "Calculated maximum combustion temperature inside the engine"
   annotation (Dialog(tab="Thermal"));
  Modelica.SIunits.Temperature T_CylWall
    "Temperature of cylinder wall";
 /* Modelica.SIunits.Temperature T_LogMeanCool
 "Mean logarithmic coolant temperature" annotation (Dialog(tab="Thermal")); */
  Modelica.SIunits.Temperature T_Exh
    "Inlet temperature of exhaust gas" annotation (Dialog(group="Thermal"));
  Modelica.SIunits.Temperature T_ExhPowUniOut
    "Outlet temperature of exhaust gas"
    annotation (Dialog(tab="Thermal"));
  type RotationSpeed=Real(final unit="1/s", min=0);
  Modelica.SIunits.MassFlowRate m_Exh
    "Mass flow rate of exhaust gas" annotation (Dialog(tab="Thermal"));
  Modelica.SIunits.SpecificHeatCapacity meanCpExh
    "Mean specific heat capacity of the exhaust gas" annotation (Dialog(tab="Thermal"));

protected
  Modelica.SIunits.ThermalConductance CalT_Exh
 "Calculation condition for the inlet temperature of exhaust gas";

/*Modelica.SIunits.Temperature T_CoolSup=363.15
    "Temperature of coolant outlet" annotation (Dialog(tab="Thermal"));
  Modelica.SIunits.Temperature T_CoolRet=350.15
    "Temperature of coolant inlet" annotation (Dialog(tab="Thermal"));
  Real QuoT_SupRet=T_CoolSup/T_CoolRet
    "Quotient of coolant supply and return temperature";
*/

public
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_Ambient
    annotation (Placement(transformation(extent={{-12,-112},{12,-88}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor innerWall(
    C=CEngWall,
    der_T(fixed=false, start=0),
    T(start=T_Amb,
      fixed=true))       annotation (Placement(transformation(
        origin={-24,-58},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.RealExpression realExpr1(y=innerWall.T)
    annotation (Placement(transformation(extent={{-116,-48},{-96,-28}})));
  Modelica.Blocks.Sources.RealExpression realExpr2(y=T_CylWall) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-106,-58})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor innerThermalCond2_1(G=GInnWall/2)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                                                                   rotation=0,
        origin={-10,0})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow actualHeatFlowEngine
    annotation (Placement(transformation(extent={{-56,-58},{-36,-38}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineHousing_CylToInnerWall
    cylToInnerWall(
    GInnWall=GInnWall,
    dInn=dInn,
    lambda=lambda,
    A_WInn=A_WInn,
    z=z) annotation (Placement(transformation(rotation=0, extent={{-84,-58},{-64,
            -38}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_CoolingCircle
    annotation (Placement(transformation(extent={{88,-12},{112,12}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor engHeatToCoolant
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents.GasolineEngineChp_EngineHousing_EngineBlock
    engineBlock(
    CEngBlo=CEngBlo,
    GInnWall=GInnWall,
    GEngBlo=GEngBlo,
    dInn=dInn,
    dOut=dOut,
    lambda=lambda,
    rhoEngWall=rhoEngWall,
    c=c,
    A_WInn=A_WInn,
    z=z,
    mEngBlo=mEngBlo,
    mEng=mEng,
    mEngWall=mEngWall,
    GEngToAmb=GEngToAmb,
    outerEngineBlock(T(start=T_Amb))) annotation (Placement(transformation(
          rotation=0, extent={{-6,-46},{14,-26}})));

  Modelica.Blocks.Sources.RealExpression calculatedExhaustTemp(y=T_Exh)
    annotation (Placement(transformation(extent={{-30,10},{-48,30}})));
  Modelica.Blocks.Interfaces.RealOutput exhaustGasTemperature
    annotation (Placement(transformation(extent={{-72,8},{-96,32}})));
equation

 /* if EngOp and m_Exh>0.001 then
  T_CylWall=0.5*(T_Com+T_Amb)*CalTCyl;
  else
  T_CylWall=T_Amb;
  end if;*/
  if nEng*60>=800 then
  T_CylWall=T_Amb+0.2929*(T_Com-T_Amb);
  else
  T_CylWall=innerWall.T;
  end if;
  CalT_Exh = if (meanCpExh*m_Exh<0.001) then 1000000 else meanCpExh*m_Exh;
  T_Exh=T_ExhPowUniOut + (cylToInnerWall.maximumEngineHeat.y
 - actualHeatFlowEngine.Q_flow)/CalT_Exh;
 // T_CylWall=T_Amb+0.2929*(T_Com-T_Amb);
  // T_CylWall=(T_Com-T_Amb)/Modelica.Math.log(T_Com/T_Amb);

 /* if abs(QuoT_SupRet-1)>0.0001 then
  T_LogMeanCool=(T_CoolSup-T_CoolRet)/Modelica.Math.log(QuoT_SupRet);
  else
  T_LogMeanCool=T_CoolRet;
  end if; */

  connect(actualHeatFlowEngine.port,innerWall. port)
    annotation (Line(points={{-36,-48},{-24,-48}},color={191,0,0}));
  connect(engineBlock.port_a, innerWall.port) annotation (Line(points={{-5,-32},
          {-24,-32},{-24,-48}},      color={191,0,0}));
  connect(cylToInnerWall.y, actualHeatFlowEngine.Q_flow)
    annotation (Line(points={{-63.4,-48},{-56,-48}}, color={0,0,127}));
  connect(cylToInnerWall.T, realExpr2.y) annotation (Line(points={{-83.8,-51},{
          -92,-51},{-92,-58},{-95,-58}},
                                       color={0,0,127}));
  connect(realExpr1.y, cylToInnerWall.T1) annotation (Line(points={{-95,-38},{
          -92,-38},{-92,-45},{-83.8,-45}},
                                        color={0,0,127}));
  connect(engineBlock.port_a1, port_Ambient)
    annotation (Line(points={{0,-45},{0,-100}}, color={191,0,0}));
  connect(innerThermalCond2_1.port_a, innerWall.port)
    annotation (Line(points={{-20,0},{-24,0},{-24,-48}}, color={191,0,0}));
  connect(port_CoolingCircle, engHeatToCoolant.port_b)
    annotation (Line(points={{100,0},{50,0}}, color={191,0,0}));
  connect(calculatedExhaustTemp.y, exhaustGasTemperature)
    annotation (Line(points={{-48.9,20},{-84,20}}, color={0,0,127}));
  connect(innerThermalCond2_1.port_b, engHeatToCoolant.port_a)
    annotation (Line(points={{0,0},{30,0}}, color={191,0,0}));
  annotation (
    Documentation(revisions="<html>
<ul>
<li><i>October, 2016&nbsp;</i> by Peter Remmen:<br/>Transfer to AixLib.</li>
<li><i>October 7, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>
", info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Engine&nbsp;housing&nbsp;as&nbsp;a&nbsp;simple&nbsp;two&nbsp;layer&nbsp;wall.</p>
<h4>Assumptions</h4>
<p>- Aus einzelnen Zylindern wird eine Gesamtfl&auml;che (Annahme: Zylinder liegt im unteren Totpunkt) berechnet und die W&auml;rmeleitung als ebene Wand modelliert</p>
<p>-&gt; N&auml;herung der unbekannten Motorengeometrie mit zu kalibrierenden W&auml;rme&uuml;berg&auml;ngen an Umgebung und K&uuml;hlwasserkreislauf</p>
<p>- Motorblock besteht aus einem homogenen Material mit bekanntem Gesamtgewicht und teilt sich in einen inneren und einen &auml;u&szlig;eren Teil auf (default ist Grauguss)</p>
<p>- &Ouml;lkreislauf wird zur Vereinfachung als Kapazit&auml;t in dem &auml;u&szlig;eren Motorblock ber&uuml;cksichtigt</p>
<p>-&gt; K&uuml;hlwasserkreislauf liegt zwischen diesen beiden Teilen (nur &auml;u&szlig;erer Teil wechselwirkt mit der Umgebung)</p>
<p>-&gt; Dicke des inneren Motorblocks ist eine wesentliche, aber unbekannte Gr&ouml;&szlig;e (Literatur gibt Werte um 5mm f&uuml;r PKW-Motoren an)</p>
<p>-&gt; Anbauteile und einzelne unterschiedliche Materialschichten im Motorblock bleiben zur Vereinfachung unber&uuml;cksichtigt und k&ouml;nnen durch Kalibration angen&auml;hert werden</p>
<p>- Das isolierende/d&auml;mmende Geh&auml;use der Erzeugereinheit besitzt keine eigene Kapazit&auml;t</p>
<p>-&gt; Erh&ouml;hte Komplexit&auml;t der Modelle wird so vermieden (W&auml;rmeverlust an Umgebung sehr gering)</p>
<p>- W&auml;rme&uuml;bergang (Zylinderwand zu K&uuml;hlwasserkreislauf) wird kalibriert und ist proportional zur Temperaturdifferenz </p>
<p>-&gt; Annahme eines konstanten Durchflusses von K&uuml;hlwasser und Geometrie der K&uuml;hlkan&auml;le ist unbekannt, daher keine Berechnung eines konvektiven W&auml;rme&uuml;bergangs zum K&uuml;hlwasserkreislauf</p>
<p>- Zylinderwand mit homogenem Temperaturprofil gebildet aus der Umgebungstemperatur und der maximalen Verbrennungstemperatur (Temperaturverlauf in Zylinder als Dreieck mit T_Amb - T_Com - T_Amb)</p>
<p>-&gt; Bestimmung einer mittleren Zylinderwandtemperatur mithilfe einer Fl&auml;chenhalbierenden im Temperaturverlauf</p>
<p align=\"center\"><img src=\"modelica://AixLib/Resources/Images/Fluid/BoilerCHP/CylinderWallTemperature.png\" width=\"426\" height=\"300\"
alt=\"Calculation of the cylinder wall temperature\"/> </p>
<p>- From individual cylinders, a total area (assumption: cylinder is at bottom dead center) is calculated and the heat conduction is modeled as a flat wall</p>
<p>-&gt; Approximation of the unknown motor geometry with heat transfers to the environment and the cooling water circuit to be calibrated</p>
<p>- Engine block consists of a homogeneous material with known total weight and is divided into an inner and an outer part (default is gray cast iron)</p>
<p>- Oil circuit is considered as a capacity in the outer engine block for simplicity</p>
<p>-&gt; Cooling water circuit lies between these two parts (only outer part interacts with the environment)</p>
<p>-&gt; Thickness of the inner engine block is an essential, but unknown size (literature indicates values ​​around 5mm for car engines)</p>
<p>-&gt; Attachments and individual different material layers in the engine block are not taken into account for simplicity and can be approximated by calibration</p>
<p>- The insulating housing of the power unit has no own capacity</p>
<p>-&gt; Increased complexity of the models is thus avoided (heat loss to environment on very low level)</p>
<p>- Heat transfer (cylinder wall to cooling water circuit) is calibrated and is proportional to the temperature difference</p>
<p>-&gt; Assumption of a constant flow of cooling water and geometry of the cooling channels is unknown, therefore no calculation of a convective heat transfer to the cooling water circuit</p>
<p>Cylinder wall with homogeneous temperature profile formed from the ambient temperature and the maximum combustion temperature (temperature curve in cylinder as a triangle with T_Amb - T_Com - T_Amb)</p>
<p>-&gt; Determination of a mean cylinder wall temperature using a bisector in the temperature profile</p>
</html>"),
         Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
              graphics={
        Rectangle(
          extent={{-80,80},{-50,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-50,80},{-20,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,80},{20,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,80},{52,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{50,80},{80,-80}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-86,98},{84,82}},
          lineColor={28,108,200},
          textStyle={TextStyle.Bold},
          textString="%name")}),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})));
end EngineHousing0901;
