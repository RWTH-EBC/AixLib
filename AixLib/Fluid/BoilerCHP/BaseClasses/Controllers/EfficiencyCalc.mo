within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model EfficiencyCalc

  parameter Modelica.SIunits.Temp_C T_cold_dim=35;
   parameter Modelica.SIunits.HeatFlowRate Q_nom=50000; // thermische Nennleistung [W]
   parameter AixLib.DataBase.Boiler.EtaTExhaust.EtaTExhaustBaseDataDefinition paramEta=AixLib.DataBase.Boiler.EtaTExhaust.Ambient1();
   parameter Real EtaTable[:,2]=paramEta.EtaTable;
    parameter Modelica.SIunits.TemperatureDifference dT_water_dim=15; // Auslegungstemperaturdifferenz



    constant Modelica.SIunits.SpecificHeatCapacity cp=4180;
   constant Modelica.SIunits.SpecificEnergy H=55498*1000;


  Modelica.Blocks.Tables.CombiTable1D combiTable1D(
    tableOnFile=false,
    table=EtaTable,
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    "Table with efficiency parameters"
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{26,-16},{46,4}})));
 Modelica.Blocks.Interfaces.RealInput Eta_losses
    "Change of Eta because of thermal losses" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Blocks.Interfaces.RealOutput m_flowFuel(quantity="MassFlowRate",
      final unit="kg/s")
    annotation (Placement(transformation(extent={{100,50},{120,70}})));


 Modelica.Blocks.Interfaces.RealInput PLR annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,40})));
 Modelica.Blocks.Interfaces.RealInput TExhaust(
    final quantity="Temperature",
    final unit="degC",
    displayUnit="degC") "Temperature boiler ambient"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation

   m_flowFuel=PLR*Q_nom/((add.y)*H);

  connect(TExhaust, combiTable1D.u[1])
    annotation (Line(points={{-120,0},{-32,0}}, color={0,0,127}));
  connect(combiTable1D.y[1], add.u1)
    annotation (Line(points={{-9,0},{24,0}}, color={0,0,127}));
  connect(Eta_losses, add.u2) annotation (Line(points={{0,-100},{-2,-100},{-2,-12},
          {24,-12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EfficiencyCalc;
