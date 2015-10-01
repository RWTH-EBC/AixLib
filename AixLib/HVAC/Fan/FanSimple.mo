within AixLib.HVAC.Fan;
model FanSimple "Simple Fan Model"
  import AixLib;
  extends Interfaces.TwoPortMoistAirFluidprops;
  outer BaseParameters baseParameters "System properties";
  parameter AixLib.DataBase.Fans.FanCharacteristicsBaseDataDefinition Characteristics = AixLib.DataBase.Fans.Fan1()
    "dp = f(V_flow)  characteristics for the Fan (n = const)"                                                                                                     annotation(choicesAllMatching = true);
  parameter Boolean UseRotationalSpeedInput = false
    "If true, rotational speed (n/n_0) can be varied by real input"                                                 annotation(Evaluate = true, HideResult = true, choices(checkBox = true));
  Modelica.SIunits.VolumeFlowRate Volflow(min = 0) "Volume Flow before Fan";
  Modelica.SIunits.Pressure PressureIncrease(min = 0)
    "Pressure Increase of Fan";
  Real eta "efficieny of Fan";
  Modelica.SIunits.EnthalpyFlowRate H_flow_a "Enthalpy at port a in W";
  Modelica.SIunits.EnthalpyFlowRate H_flow_b "Enthalpy at port b in W";
  Modelica.SIunits.Power P_t "Technical Work of Fan";
  Modelica.SIunits.Power P_t_rev "Reversible technical Work of Fan";
  Modelica.Blocks.Tables.CombiTable1Ds table_Characteristics(tableOnFile = false, table = Characteristics.dp, smoothness = Modelica.Blocks.Types.Smoothness.LinearSegments, columns = {2, 3})
    "Table with dp = f(V_flow) and eta = f(V_flow) characteristics for the Fan (n = const)"
                                                                                                        annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput Power annotation(Placement(transformation(extent = {{-12, -12}, {12, 12}}, rotation = 270, origin = {0, -104})));
  Modelica.Blocks.Interfaces.RealInput n_relative(min = 0, max = 1) if UseRotationalSpeedInput annotation(Placement(transformation(extent = {{-14, -16}, {14, 16}}, rotation = 270, origin = {0, 106})));
protected
  Modelica.Blocks.Interfaces.RealInput n_internal
    "Needed to connect to conditional connector";
initial equation

equation
  assert(Volflow >= 0, "Backflow occurs through Fan, check Boundaries");
  assert(PressureIncrease >= 0, "Pressure behind Fan is lower than befor Fan, check Boundaries");
  assert(0 <= n_internal and n_internal <= 1, "relative rotational Speed must be between 0 and 1, check input");
  portMoistAir_a.m_flow + portMoistAir_b.m_flow = 0;
  portMoistAir_b.X_outflow = actualStream(portMoistAir_a.X_outflow);
  portMoistAir_a.X_outflow = actualStream(portMoistAir_b.X_outflow);
  portMoistAir_a.h_outflow = inStream(portMoistAir_b.h_outflow);
  //nothing happens in case of backflow
  // ENERGY BALANCE
  connect(n_internal, n_relative);
  if not UseRotationalSpeedInput then
    n_internal = 1;
  end if;
  P_t_rev = Volflow * PressureIncrease;
  P_t = P_t_rev / eta;
  H_flow_a = portMoistAir_a.m_flow * actualStream(portMoistAir_a.h_outflow);
  //H_flow_b = portMoistAir_b.m_flow*portMoistAir_b.h_outflow;
  portMoistAir_b.h_outflow = if portMoistAir_b.m_flow < 0 then H_flow_b / portMoistAir_b.m_flow else 0;
  H_flow_a + H_flow_b + P_t = 0;
  dp = -PressureIncrease;
  table_Characteristics.u = Volflow / n_internal * 3600;
  eta = table_Characteristics.y[2];
  PressureIncrease = n_internal * n_internal * table_Characteristics.y[1];
  Volflow = portMoistAir_a.m_flow / rho_MoistAir;
  Power = P_t;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Ellipse(extent=  {{-100, 100}, {100, -100}}, lineColor=  {0, 0, 0},
            fillPattern=                                                                                                    FillPattern.Solid, fillColor=  {170, 255, 255}), Line(points=  {{-78, 60}, {92, 40}, {90, 40}}, color=  {0, 0, 0}), Line(points=  {{-80, -60}, {92, -40}, {92, -40}}, color=  {0, 0, 0})}), Documentation(info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>A simple fan model with variation of rotational speed. The properties of the fan are table based.</p>
 <h4><span style=\"color:#008000\">Level of Development</span></h4>
 <p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
 <h4><span style=\"color:#008000\">Example Results</span></h4>
 <p><a href=\"AixLib.HVAC.Fan.Examples.SpeedControlOfFan\">AixLib.HVAC.Fan.Examples.SpeedControlOfFan</a> </p>
 <p><a href=\"AixLib.HVAC.Fan.Examples.FansSerialAndParallel\">AixLib.HVAC.Fan.Examples.FansSerialAndParallel</a> </p>
 </html>", revisions = "<html>
 <p>30.12.2013, Mark Wesseling</p>
 <ul>
 <li>implemented</li>
 </ul>
 </html>"));
end FanSimple;
