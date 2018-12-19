within AixLib.Fluid.BoilerCHP.ModularCHP.OldModels;
model engineBlockToAmbient1812
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor
    innerThermalCond2_2(G=GInnWall/2) annotation (Placement(transformation(
          extent={{-18,-44},{2,-24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor outerThermalCond(
      G=GEngBlo/2) annotation (Placement(transformation(extent={{14,-44},{34,
            -24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor outerEngineBlock(
    der_T(fixed=false, start=0),
    C=CEngBlo,
    T(fixed=true, start=298.15)) annotation (Placement(transformation(
        origin={46,-44},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor outerThermalCond2(
     G=GEngBlo/2) annotation (Placement(transformation(extent={{58,-44},{78,-24}},
          rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor engineToAir(G=
        GEngToAir) annotation (Placement(transformation(extent={{48,-84},{68,
            -64}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor toAmbient(G=
        GAirToAmb) annotation (Placement(transformation(extent={{14,-84},{34,
            -64}}, rotation=0)));
  parameter Modelica.SIunits.HeatCapacity CEngBlo=dOut*A_WInn*rhoEngWall*c
    "Heat capacity of the remaining engine body"
    annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GEngToAir = A_WInn*alpha_Air
    "Thermal conductance from engine housing to the surrounding air" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GAirToAmb=0.3612
    "Thermal conductance from the sorrounding air to the ambient" annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GInnWall=lambda*A_WInn/dInn
  "Thermal conductance of the inner engine wall"
  annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.ThermalConductance GEngBlo=lambda*A_WInn/dOut
  "Thermal conductance of the outer engine wall"
  annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.Thickness dInn=0.005
    "Typical value for the thickness of the cylinder wall (between combustion chamber and cooling circle)"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.Thickness dOut=mEngBlo/A_WInn/rhoEngWall
    "Thickness of outer wall of the remaining engine body"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.ThermalConductivity lambda=44.5
    "Thermal conductivity of the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.SIunits.Density rhoEngWall=72000
    "Density of the the engine block material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.SIunits.SpecificHeatCapacity c=535
    "Specific heat capacity of the cylinder wall material" annotation (Dialog(tab="Structure", group="Material Properties"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer alpha_Air = 3.84 "Coefficient of heat transfer for air inside and outside the power unit (for DeltaT=15K)"
   annotation (Dialog(group="Thermal"));
  parameter Modelica.SIunits.Area A_WInn=z*(Modelica.Constants.pi*dCyl*(dCyl/2 +
      hStr*(1 + 1/(eps - 1))))
    "Area of heat transporting surface from cylinder wall to outer engine block"
    annotation (Dialog(tab="Structure Calculations"));
  parameter Real z
  annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Mass mEngBlo=mEng - mEngWall
    annotation (Dialog(tab="Structure Calculations"));
  parameter Modelica.SIunits.Mass mEng
  annotation (Dialog(tab="Structure", group="Engine Properties"));
  parameter Modelica.SIunits.Mass mEngWall=A_WInn*rhoEngWall*dInn
    annotation (Dialog(tab="Structure Calculations"));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (
      Placement(transformation(rotation=0, extent={{-100,30},{-80,50}}),
        iconTransformation(extent={{-100,30},{-80,50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a1 annotation (
      Placement(transformation(rotation=0, extent={{-50,-100},{-30,-80}}),
        iconTransformation(extent={{-50,-100},{-30,-80}})));
equation
  connect(outerThermalCond.port_b,outerEngineBlock. port)
    annotation (Line(points={{34,-34},{46,-34}}, color={191,0,0}));
  connect(outerThermalCond.port_a,innerThermalCond2_2. port_b)
    annotation (Line(points={{14,-34},{2,-34}},  color={191,0,0}));
  connect(outerEngineBlock.port,outerThermalCond2. port_a)
    annotation (Line(points={{46,-34},{58,-34}}, color={191,0,0}));
  connect(engineToAir.port_a, toAmbient.port_b)
    annotation (Line(points={{48,-74},{34,-74}}, color={191,0,0}));
  connect(engineToAir.port_b, outerThermalCond2.port_b) annotation (Line(
        points={{68,-74},{86,-74},{86,-34},{78,-34}}, color={191,0,0}));
  connect(port_a, innerThermalCond2_2.port_a) annotation (Line(points={{-90,40},
          {-60,40},{-60,-34},{-18,-34}},     color={191,0,0}));
  connect(port_a1, toAmbient.port_a) annotation (Line(points={{-40,-90},{-40,
          -74},{14,-74}}, color={191,0,0}));
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
to ambient")}));
end engineBlockToAmbient1812;
