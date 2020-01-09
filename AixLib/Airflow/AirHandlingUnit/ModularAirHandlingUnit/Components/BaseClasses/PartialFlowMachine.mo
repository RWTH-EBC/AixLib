within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.BaseClasses;
partial model PartialFlowMachine

   parameter Boolean use_WeatherData = false
    "set true to enable weather data";
  parameter Boolean use_inputFilter = false
    "= true, if speed is filtered with a 2nd order CriticalDamping filter";
  parameter Boolean computePowerUsingSimilarityLaws
    "= true, compute power exactly, using similarity laws. Otherwise approximate.";
  parameter Modelica.SIunits.Time riseTime=30
    "Rise time of the filter (time to reach 99.6 % of the speed)"
    annotation(Dialog(tab="Dynamics", group="Filtered speed",enable=use_inputFilter));
  parameter Modelica.Blocks.Types.Init init=Modelica.Blocks.Types.Init.InitialOutput
    "Type of initialization (no init/steady state/initial state/initial output)"
    annotation(Dialog(tab="Dynamics", group="Filtered speed",enable=use_inputFilter));
  parameter Real y_start(min=0, max=1, unit="1")=0 "Initial value of speed"
    annotation(Dialog(tab="Dynamics", group="Filtered speed",enable=use_inputFilter));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal "Nominal mass flow rate" annotation(Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of dry air";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";

  final parameter Modelica.SIunits.Density rho_air = 1.2 "Density of air";

  Modelica.SIunits.SpecificEnthalpy h_airIn "incoming enthalpy of air";
  Modelica.SIunits.SpecificEnthalpy h_airOut "outgoing enthalpy of air";
  Modelica.SIunits.HeatFlowRate Q_flow "Heat input into air";

  constant Modelica.SIunits.SpecificEnthalpy r0 = 2500E3 "specific heat of vaporization at 0°C";

  Modelica.Blocks.Interfaces.RealInput m_flow_in "Prescribed mass flow rate"
    annotation (Placement(transformation(extent={{-128,-14},{-100,14}})));
  Modelica.Blocks.Interfaces.RealInput T_airIn if not use_WeatherData
    "Prescribed Temperature"
    annotation (Placement(transformation(extent={{-128,-54},{-100,-26}})));
  Modelica.Blocks.Interfaces.RealInput X_airIn if not use_WeatherData
    "Prescribed Massfraction"
    annotation (Placement(transformation(extent={{-128,-94},{-100,-66}})));
  Modelica.Blocks.Interfaces.RealOutput P "Electrical power consumed"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOut "Temperature of outgoing air"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOut "Massfraction of outgoing air"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_out "Outgoing massflowrate"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Modelica.Blocks.Routing.RealPassThrough T_in "Temperature of incoming air"
    annotation (Placement(transformation(extent={{-30,44},{-10,64}})));
  Modelica.Blocks.Routing.RealPassThrough X_in "Massfraction of incoming air"
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
AixLib.BoundaryConditions.WeatherData.Bus weaBus if  use_WeatherData
    annotation (Placement(transformation(extent={{-110,80},{-90,100}})));

replaceable parameter AixLib.Fluid.Movers.Data.Generic per
    constrainedby AixLib.Fluid.Movers.Data.Generic
    "Record with performance data"
    annotation (choicesAllMatching=true,
      Placement(transformation(extent={{52,60},{72,80}})));

protected
      final parameter Integer nOri = size(per.pressure.V_flow, 1)
    "Number of data points for pressure curve"
    annotation(Evaluate=true);

    final parameter Boolean haveVMax = (abs(per.pressure.dp[nOri]) < Modelica.Constants.eps)
    "Flag, true if user specified data that contain V_flow_max";

    final parameter Modelica.SIunits.VolumeFlowRate V_flow_max=
    if per.havePressureCurve then
    (if haveVMax then
      per.pressure.V_flow[nOri]
     else
      per.pressure.V_flow[nOri] - (per.pressure.V_flow[nOri] - per.pressure.V_flow[
      nOri - 1])/((per.pressure.dp[nOri] - per.pressure.dp[nOri - 1]))*per.pressure.dp[nOri])
    else
      m_flow_nominal/rho_air "Maximum volume flow rate, used for smoothing";

       AixLib.Fluid.Movers.BaseClasses.PowerInterface heaDis(final motorCooledByFluid=per.motorCooledByFluid,
    final delta_V_flow=1E-3*V_flow_max)  "Heat dissipation into medium"
    annotation (Placement(transformation(extent={{12,-52},{32,-32}})));
  Modelica.Blocks.Math.Add PToMed(final k1=1, final k2=1) "Heat and work input into medium"
    annotation (Placement(transformation(extent={{42,-62},{62,-42}})));
 Modelica.Blocks.Sources.RealExpression density_air(y=rho_air)
    annotation (Placement(transformation(extent={{-60,-106},{-40,-86}})));
  AixLib.Fluid.Movers.BaseClasses.FlowMachineInterface eff(
    per(
      final hydraulicEfficiency=per.hydraulicEfficiency,
      final motorEfficiency=per.motorEfficiency,
      final motorCooledByFluid=per.motorCooledByFluid,
      final speed_nominal=0,
      final constantSpeed=0,
      final speeds={0},
      final power=per.power),
    computePowerUsingSimilarityLaws=computePowerUsingSimilarityLaws,
    rho_default=rho_air,
    haveVMax=haveVMax,
    r_N(start=y_start),
    r_V(start=m_flow_nominal/rho_air),
    V_flow_max=V_flow_max,
    nOri=nOri)
    annotation (Placement(transformation(extent={{-30,-64},{-10,-44}})));
 AixLib.Utilities.Psychrometrics.X_pTphi x_pTphi(use_p_in=false) if use_WeatherData
                                                  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,90})));
  AixLib.Utilities.Psychrometrics.ToTotalAir toTotAir if use_WeatherData annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={22,90})));

equation

  PToMed.y = Q_flow;

  h_airIn = cp_air*(T_in.y - 273.15) + X_in.y*(cp_steam*(T_in.y - 273.15) +
    r0);
  h_airOut = cp_air*(T_airOut - 273.15) + X_airOut*(cp_steam*(T_airOut - 273.15)
     + r0);

  Q_flow = -(m_flow_in * h_airIn - m_flow_out * h_airOut);

if use_WeatherData then
   connect(weaBus.TDryBul, T_in.u) annotation (Line(
      points={{-100,90},{-100,54},{-32,54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
    connect(toTotAir.XiTotalAir, X_in.u) annotation (Line(points={{33,90},{40,90},
            {40,40},{-58,40},{-58,20},{-32,20}},
                                           color={0,0,127}));

  connect(x_pTphi.X[1],toTotAir. XiDry)
    annotation (Line(points={{1,90},{11,90}},    color={0,0,127}));
  connect(weaBus.TDryBul, x_pTphi.T) annotation (Line(
      points={{-100,90},{-22,90}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus.relHum, x_pTphi.phi)
   annotation (Line(
      points={{-100,90},{-32,90},{-32,84},{-22,84}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

    connect(weaBus, weaBus) annotation (Line(
        points={{-100,90},{-100,90}},
        color={255,204,51},
        thickness=0.5));
end if;

  connect(PToMed.u1,heaDis. Q_flow) annotation (Line(points={{40,-46},{36,-46},{
          36,-42},{33,-42}}, color={0,0,127}));
  connect(m_flow_in, eff.m_flow) annotation (Line(points={{-114,1.77636e-15},{
          -58,1.77636e-15},{-58,-50},{-32,-50}},
                           color={0,0,127}));
  connect(density_air.y, eff.rho) annotation (Line(points={{-39,-96},{-36,-96},{
          -36,-60},{-32,-60}}, color={0,0,127}));
  connect(eff.V_flow, heaDis.V_flow) annotation (Line(points={{-9,-49.2},{0,-49.2},
          {0,-38},{10,-38}}, color={0,0,127}));
  connect(eff.etaHyd, heaDis.etaHyd) annotation (Line(points={{-9,-61},{0,-61},{
          0,-32},{10,-32}}, color={0,0,127}));
  connect(eff.WFlo, heaDis.WFlo) annotation (Line(points={{-9,-52},{0,-52},{0,-46},
          {10,-46}}, color={0,0,127}));
  connect(PToMed.u2, eff.WFlo) annotation (Line(points={{40,-58},{0,-58},{0,-52},
          {-9,-52}}, color={0,0,127}));
  connect(m_flow_out, m_flow_in)
    annotation (Line(points={{110,0},{-114,0},{-114,1.77636e-15}},
                                                         color={0,0,127}));

  if not use_WeatherData then
      connect(T_airIn, T_in.u) annotation (Line(points={{-114,-40},{-58,-40},{
            -58,54},{-32,54}},
                     color={0,0,127}));
       connect(X_airIn, X_in.u) annotation (Line(points={{-114,-80},{-58,-80},{
            -58,20},{-32,20}},
                     color={0,0,127}));

  end if;

  connect(X_in.y, X_airOut) annotation (Line(points={{-9,20},{80,20},{80,-80},{
          110,-80}},
                 color={0,0,127}));

            annotation (
    preferredView="info",
    Documentation(info="<html>
    
    <p>

</p>This is the base model for fans. It is later used to calculate the electrial Power and the temperature increase of the air flowing through.<p>
</p> <p>


</p>
<h4>Main Equations</h4>

<p align=\"center\"><i>Q_flow = -(m_flow_in * h_airIn - m_flow_out * h_airOut)</i></p>

</p>The outgoing enthalpy is beeing calculated and then used to calculate the outgoing air temperature. <p>
<p align=\"center\"><i>h_airOut = cp_air*(T_airOut - 273.15) + X_airOut*(cp_steam*(T_airOut - 273.15)
     + r0);</i></p>
<p>
</p>


</p>

    
</html>", revisions="<html>
<ul>

<li>September 2 , 2019, by Ervin Lejlic:<br>First Implementation</li>
</ul>
</html>"),    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialFlowMachine;
