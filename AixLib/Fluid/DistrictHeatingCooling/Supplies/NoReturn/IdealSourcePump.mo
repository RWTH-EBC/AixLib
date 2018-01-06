within AixLib.Fluid.DistrictHeatingCooling.Supplies.NoReturn;
model IdealSourcePump
  extends BaseClasses.Supplies.NoReturn.PartialSupply(redeclare
      Controllers.Temperature.InputTemperature controllerT);
  Movers.FlowControlled_dp              gridPump(
    redeclare package Medium = Medium,
    m_flow_nominal=3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Sources.Boundary_pT              heaterSource(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Continuous.LimPID PID
    annotation (Placement(transformation(extent={{-56,-48},{-36,-68}})));
  Modelica.Blocks.Sources.Constant p_NSP_set(k=2.5)
    "Set value of pressure at Netzschlechtpunkt"
    annotation (Placement(transformation(extent={{-98,-88},{-78,-68}})));
  Modelica.Blocks.Interfaces.RealInput T_heater
    "Flow temperature in Celsius (70/110)" annotation (Placement(transformation(
          extent={{-126,50},{-86,90}}),  iconTransformation(extent={{-126,50},{
            -86,90}})));
  Modelica.Blocks.Interfaces.RealInput p_NSP "Pressure at Netzschlechtpunkt"
    annotation (Placement(transformation(extent={{-126,-60},{-86,-20}}),
        iconTransformation(extent={{-126,-60},{-86,-20}})));
  Modelica.Blocks.Interfaces.RealOutput P_gridPump "Power of grid pump "
    annotation (Placement(transformation(extent={{80,40},{120,80}}),
        iconTransformation(extent={{80,40},{120,80}})));
equation
  connect(heaterSource.ports[1],gridPump. port_a)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,127,255}));
  connect(p_NSP,PID. u_m)
    annotation (Line(points={{-106,-40},{-46,-40},{-46,-46}},
                                                           color={0,0,127}));
  connect(gridPump.P, P_gridPump) annotation (Line(points={{11,9},{20,9},{20,60},
          {100,60}}, color={0,0,127}));
  connect(p_NSP_set.y, PID.u_s) annotation (Line(points={{-77,-78},{-68,-78},{
          -68,-58},{-58,-58}}, color={0,0,127}));
  connect(PID.y, gridPump.dp_in) annotation (Line(points={{-35,-58},{-22,-58},{
          -22,20},{0,20},{0,12}}, color={0,0,127}));
  connect(T_heater, controllerT.T)
    annotation (Line(points={{-106,70},{-80.6,70}}, color={0,0,127}));
  connect(controllerT.y, heaterSource.T_in) annotation (Line(points={{-59,70},{
          -50,70},{-50,30},{-80,30},{-80,4},{-62,4}}, color={0,0,127}));
  connect(gridPump.port_b, senT_supply.port_a)
    annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
end IdealSourcePump;
