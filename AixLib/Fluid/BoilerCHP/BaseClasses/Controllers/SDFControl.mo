within AixLib.Fluid.BoilerCHP.BaseClasses.Controllers;
model SDFControl


   parameter Modelica.SIunits.Temp_C T_cold_set=35; // Rücklauf Setpoint
   parameter Modelica.SIunits.HeatFlowRate Q_nom=50000; // thermische Nennleistung
  parameter AixLib.DataBase.Boiler.EtaTExhaust.EtaTExhaustBaseDataDefinition paramEta=AixLib.DataBase.Boiler.EtaTExhaust.Ambient1();
   parameter Real EtaTable[:,2]=paramEta.EtaTable;

   Real dT_control;
   constant Modelica.SIunits.SpecificHeatCapacity cp=4180;
   constant Modelica.SIunits.SpecificEnergy H=55498*1000;


  SDF.NDTable BoilerBehaviour(
    nin=3,
    readFromFile=false,
    filename=("D:/dja-mzu/BoilerBehaviour.sdf"),
    dataset="/ExhaustTemp",
    dataUnit="degC",
    scaleUnits={"degC","K","-"},
    interpMethod=SDF.Types.InterpolationMethod.Linear,
    data=SDF.Functions.readTableData(
        BoilerBehaviour.filename,
        BoilerBehaviour.dataset,
        BoilerBehaviour.dataUnit,
        BoilerBehaviour.scaleUnits))
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
 Modelica.Blocks.Interfaces.RealInput dT_water(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="K") "calculated temperature difference water setpoint"
    annotation (Placement(transformation(extent={{-120,60},{-80,100}})));
 Modelica.Blocks.Interfaces.RealInput m_flow_water(
    final quantity="MassFlowRate",
    final unit="kg/s",
    displayUnit="kg/s") "Water mass flow Setpoint" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,40})));
 Modelica.Blocks.Interfaces.RealInput T_cold(
    final quantity="Temperature",
    final unit="degC",
    displayUnit="degC") "Measured temperature of Water return flow"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,0})));

  Modelica.Blocks.Sources.RealExpression Real2(y=dT_control/1)
    "Difference temperature"
    annotation (Placement(transformation(extent={{-62,-34},{-42,-14}})));
  Modelica.Blocks.Sources.RealExpression Real3(y=PLR/1) "Part load ratio"
    annotation (Placement(transformation(extent={{-64,-60},{-44,-40}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(
    tableOnFile=false,
    table=EtaTable,
    columns={2},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    "Table with efficiency parameters"
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));
 Modelica.Blocks.Interfaces.RealInput Eta_losses
    "Change of Eta because of thermal losses" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{48,-58},{68,-38}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_fuel(quantity="MassFlowRate",
      final unit="kg/s")
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput T_exhaust(final quantity="Temperature",
      final unit="degC")
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  T_hot=T_cold_set+dT_water;
  dT_control=T_hot-T_cold;
  PLR=m_flow_water*cp*(dT_control)/Q_nom;
  m_flow_fuel=PLR*Q_nom/((add.y)*H);

  connect(T_cold, BoilerBehaviour.u[1]) annotation (Line(points={{-100,0},{-56,0},
          {-56,-1.33333},{-10,-1.33333}}, color={0,0,127}));
  connect(Real2.y, BoilerBehaviour.u[2])
    annotation (Line(points={{-41,-24},{-10,-24},{-10,0}}, color={0,0,127}));
  connect(Real3.y, BoilerBehaviour.u[3]) annotation (Line(points={{-43,-50},{-10,
          -50},{-10,1.33333}}, color={0,0,127}));
  connect(BoilerBehaviour.y, combiTable1D.u[1])
    annotation (Line(points={{13,0},{40,0}}, color={0,0,127}));
  connect(Eta_losses, add.u2)
    annotation (Line(points={{0,-100},{0,-54},{46,-54}}, color={0,0,127}));
  connect(combiTable1D.y[1], add.u1) annotation (Line(points={{63,0},{78,0},{78,
          -22},{36,-22},{36,-42},{46,-42}}, color={0,0,127}));
  connect(BoilerBehaviour.y, T_exhaust) annotation (Line(points={{13,0},{26,0},{
          26,30},{90,30},{90,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SDFControl;
