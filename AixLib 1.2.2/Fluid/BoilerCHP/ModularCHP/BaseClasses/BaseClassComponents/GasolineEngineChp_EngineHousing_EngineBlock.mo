within AixLib.Fluid.BoilerCHP.ModularCHP.BaseClasses.BaseClassComponents;
model GasolineEngineChp_EngineHousing_EngineBlock

  parameter Modelica.Units.SI.HeatCapacity CEngBlo=dOut*A_WInn*rhoEngWall*c
    "Heat capacity of the remaining engine body"
    annotation (Dialog(group="Thermal"));
  parameter Modelica.Units.SI.ThermalConductance GEngToAmb=0.23
    "Thermal conductance from the engine block to the ambient"
    annotation (Dialog(group="Thermal"));
  parameter Modelica.Units.SI.ThermalConductance GInnWall=lambda*A_WInn/dInn
    "Thermal conductance of the inner engine wall"
    annotation (Dialog(group="Thermal"));
  parameter Modelica.Units.SI.ThermalConductance GEngBlo=lambda*A_WInn/dOut
    "Thermal conductance of the outer engine wall"
    annotation (Dialog(group="Thermal"));
  parameter Modelica.Units.SI.Temperature T_Amb=298.15 "Ambient temperature"
    annotation (Dialog(tab="Thermal"));
  parameter Modelica.Units.SI.Thickness dInn=0.005
    "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.Units.SI.Thickness dOut=mEngBlo/A_WInn/rhoEngWall
    "Thickness of outer wall of the remaining engine body"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.Units.SI.ThermalConductivity lambda=44.5
    "Thermal conductivity of the engine block material"
    annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.Units.SI.Density rhoEngWall=72000
    "Density of the the engine block material"
    annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.Units.SI.SpecificHeatCapacity c=535
    "Specific heat capacity of the cylinder wall material"
    annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.Units.SI.Area A_WInn
    "Area of heat transporting surface from cylinder wall to outer engine block"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Real z
  annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.Units.SI.Mass mEngBlo=mEng - mEngWall
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.Units.SI.Mass mEng
    annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.Units.SI.Mass mEngWall=A_WInn*rhoEngWall*dInn
    annotation (Dialog(tab="Structure Calculations"));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    "Heat port to engine block"                              annotation (
      Placement(transformation(rotation=0, extent={{-100,30},{-80,50}}),
        iconTransformation(extent={{-100,30},{-80,50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a1
    "Heat port to ambient"                                    annotation (
      Placement(transformation(rotation=0, extent={{-50,-100},{-30,-80}}),
        iconTransformation(extent={{-50,-100},{-30,-80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor innerThermalCond2(G=
        GInnWall/2) annotation (Placement(transformation(extent={{-42,-10},{-22,
            10}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor outerThermalCond(
      G=GEngBlo/2) annotation (Placement(transformation(extent={{-10,-10},{10,
            10}},  rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor outerEngineBlock(
    der_T(fixed=false, start=0),
    C=CEngBlo,
    T(start=T_Amb,
      fixed=true)) "Thermal capacity of the engine block"
                        annotation (Placement(transformation(
        origin={22,-10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor outerThermalCond2(
     G=GEngBlo/2) annotation (Placement(transformation(extent={{34,-10},{54,10}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor toAmbient(G=GEngToAmb)
                   annotation (Placement(transformation(extent={{0,-70},{20,-50}},
                   rotation=0)));

equation
  connect(outerThermalCond.port_b,outerEngineBlock. port)
    annotation (Line(points={{10,0},{22,0}},     color={191,0,0}));
  connect(outerThermalCond.port_a, innerThermalCond2.port_b)
    annotation (Line(points={{-10,0},{-22,0}}, color={191,0,0}));
  connect(outerEngineBlock.port,outerThermalCond2. port_a)
    annotation (Line(points={{22,0},{34,0}},     color={191,0,0}));
  connect(port_a, innerThermalCond2.port_a) annotation (Line(points={{-90,40},{
          -60,40},{-60,0},{-42,0}}, color={191,0,0}));
  connect(port_a1, toAmbient.port_a) annotation (Line(points={{-40,-90},{-40,
          -60},{0,-60}},  color={191,0,0}));
  connect(outerThermalCond2.port_b, toAmbient.port_b) annotation (Line(points={{54,0},{
          70,0},{70,-60},{20,-60}},            color={191,0,0}));
  annotation (Icon(graphics={Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={28,108,200},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-60,14},{58,-8}},
          lineColor={255,255,255},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.None,
          textString="EngineBlock
to ambient")}), Documentation(revisions="<html><ul>
  <li>
    <i>April, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/667\">#667</a>)
  </li>
</ul>
</html>"));
end GasolineEngineChp_EngineHousing_EngineBlock;
