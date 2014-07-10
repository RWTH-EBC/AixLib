within AixLib.HVAC;
package Sources "Contains hydraulic sources"
  extends Modelica.Icons.Package;
  model Boundary_ph
    outer BaseParameters baseParameters "System properties";

    parameter Boolean use_p_in = false
      "Get the pressure from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_h_in= false
      "Get the specific enthalpy from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));

    parameter Modelica.SIunits.Pressure p = 1e5 "Fixed value of pressure"
      annotation (Evaluate = true,
                  Dialog(enable = not use_p_in));
    parameter Modelica.SIunits.SpecificEnthalpy h = 1e5
      "Fixed value of specific enthalpy"
      annotation (Evaluate = true,
                  Dialog(enable = not use_h_in));

  protected
    Modelica.Blocks.Interfaces.RealInput p_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput h_in_internal
      "Needed to connect to conditional connector";

  public
    Interfaces.Port_a port_a
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.RealInput p_in if use_p_in
      annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
    Modelica.Blocks.Interfaces.RealInput h_in if use_h_in
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  equation
    connect(p_in, p_in_internal);
    connect(h_in, h_in_internal);

    if not use_p_in then
      p_in_internal = p;
    end if;
    if not use_h_in then
      h_in_internal = h;
    end if;

    port_a.p = p_in_internal;
    port_a.h_outflow = h_in_internal;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Sphere)}),
      Documentation(revisions="<html>
<p>01.10.2013, by <i>Pooyan Jahangiri</i>: implemented</p>
</html>",
  info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Defines prescribed values for boundary conditions: </p>
<ul>
<li>Prescribed boundary pressure.</li>
<li>Prescribed boundary temperature.</li>
</ul>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>If <code>use_p_in</code> is false (default option), the <code>p</code> parameter is used as boundary pressure, and the <code>p_in</code> input connector is disabled; if <code>use_p_in</code> is true, then the <code>p</code> parameter is ignored, and the value provided by the input connector is used instead.</p>
<p>The same thing goes for the specific enthalpy</p>
<p>Note, that boundary temperature has only an effect if the mass flow is from the boundary into the port. If mass is flowing from the port into the boundary, the boundary definitions, with exception of boundary pressure, do not have an effect. </p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.HeatGeneration.Examples.HeatPumpSystem\">AixLib.HVAC.HeatGeneration.Examples.HeatPumpSystem</a></p>
</html>"));
  end Boundary_ph;

  model Boundary_p "Pressure boundary, no enthapy, no massflow"
    outer BaseParameters baseParameters "System properties";

    parameter Boolean use_p_in = false
      "Get the pressure from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));

    parameter Modelica.SIunits.Pressure p = 1e5 "Fixed value of pressure"
      annotation (Evaluate = true,
                  Dialog(enable = not use_p_in));

  protected
    Modelica.Blocks.Interfaces.RealInput p_in_internal;

  public
    Interfaces.Port_a port_a
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.RealInput p_in if use_p_in
      annotation (Placement(transformation(extent={{-140,40},{-100,80}})));

  equation
    connect(p_in, p_in_internal);

    if not use_p_in then
      p_in_internal = p;
    end if;

    port_a.p = p_in_internal;
    port_a.h_outflow = 0;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(graphics={Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,255},
            fillColor={0,0,255},
            fillPattern=FillPattern.Sphere)}),
      Documentation(revisions="<html>
<p>01.11.2013, by <i>Ana Constantin</i>: implemented</p>
</html>", info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p><br>Boundary of fixed pressure. To be used in a loop before a pump.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Pumps.Examples.PumpHydraulicResistance_closedLoop\">AixLib.HVAC.Pumps.Examples.PumpHydraulicResistance_closedLoop</a></p>
</html>"));
  end Boundary_p;

  model OutdoorTemp "Outdoor Temperature"
    import AixLib;

    parameter AixLib.DataBase.Weather.WeatherBaseDataDefinition temperatureOT=
        AixLib.DataBase.Weather.WinterDay() "outdoor air tmeperature"
      annotation (choicesAllMatching=true);

    Modelica.Blocks.Sources.CombiTimeTable temperature(
      table=temperatureOT.temperature,
      offset={273.15},
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.RealOutput T_out
      "Connector of Real output signals"
      annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  equation
    connect(temperature.y[1], T_out) annotation (Line(
        points={{11,0},{106,0}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This source outputs the outdoor air temperature in K from a table given in database.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTVar\">AixLib.HVAC.HeatGeneration.Examples.BoilerSystemTVar</a></p>
</html>", revisions="<html>
<p>04.11.2013, Marcus Fuchs: implemented</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Ellipse(
            extent={{-54,50},{54,-56}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            fillColor={213,255,170}), Text(
            extent={{-38,44},{38,-46}},
            lineColor={0,0,255},
            fillColor={213,255,170},
            fillPattern=FillPattern.Solid,
            textString="T_out")}));
  end OutdoorTemp;

  model TempAndRad "Outdoor Temperature and solar irradiation"
    import AixLib;

    parameter AixLib.DataBase.Weather.WeatherBaseDataDefinition temperatureOT=
        AixLib.DataBase.Weather.WinterDay() "outdoor air tmeperature"
      annotation (choicesAllMatching=true);

    Modelica.Blocks.Sources.CombiTimeTable OutdoorConditions(
      table=temperatureOT.temperature,
      extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
      offset={0.01})
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Blocks.Interfaces.RealOutput T_out "Outdoor air temperature in C"
      annotation (Placement(transformation(extent={{96,-50},{116,-30}}),
          iconTransformation(extent={{96,-50},{116,-30}})));
    Modelica.Blocks.Interfaces.RealOutput Rad "Solar Irradiation in W/m2"
      annotation (Placement(transformation(extent={{96,30},{116,50}})));
    Modelica.Blocks.Math.UnitConversions.From_degC from_degC
      annotation (Placement(transformation(extent={{66,-50},{86,-30}})));
  equation
    connect(OutdoorConditions.y[2], Rad) annotation (Line(
        points={{11,0},{54,0},{54,40},{106,40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(OutdoorConditions.y[1], from_degC.u) annotation (Line(
        points={{11,0},{54,0},{54,-40},{64,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(from_degC.y, T_out) annotation (Line(
        points={{87,-40},{106,-40}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This source outputs the outdoor air temperature in K from a table given in database.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
</html>", revisions="<html>
<p>19.11.2013, Marcus Fuchs: implemented</p>
</html>"),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Ellipse(
            extent={{-54,20},{54,-86}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            fillColor={213,255,170}), Text(
            extent={{-38,16},{38,-74}},
            lineColor={0,0,255},
            fillColor={213,255,170},
            fillPattern=FillPattern.Solid,
            textString="T_out"),Ellipse(
            extent={{-56,92},{52,-14}},
            lineColor={0,0,255},
            fillPattern=FillPattern.Solid,
            fillColor={213,255,170}), Text(
            extent={{-28,64},{22,18}},
            lineColor={0,0,255},
            fillColor={213,255,170},
            fillPattern=FillPattern.Solid,
            textString="G")}));
  end TempAndRad;

  model BoundaryMoistAir_phX
    "boundary for Moist Air, pressure, enthalpy, water fraction"
    outer BaseParameters baseParameters "System properties";

    parameter Boolean use_p_in = false
      "Get the pressure from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_h_in= false
      "Get the specific enthalpy from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_X_in= false
      "Get the water mass fraction per mass dry air from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));

    parameter Modelica.SIunits.Pressure p = 1e5 "Fixed value of pressure"
      annotation (Evaluate = true,
                  Dialog(enable = not use_p_in));
    parameter Modelica.SIunits.SpecificEnthalpy h = 1e4
      "Fixed value of specific enthalpy as energy per mass dry air"
      annotation (Evaluate = true,
                  Dialog(enable = not use_h_in));

  parameter Real X(min=0,max=1) = 2e-3
      "Fixed value of water mass fraction per mass dry air"
      annotation (Evaluate = true,
                  Dialog(enable = not use_X_in));

  protected
    Modelica.Blocks.Interfaces.RealInput p_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput h_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput X_in_internal
      "Needed to connect to conditional connector";

  public
    Interfaces.PortMoistAir_a
                      portMoistAir_a
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.RealInput p_in if use_p_in
      annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
    Modelica.Blocks.Interfaces.RealInput h_in if use_h_in
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput X_in if use_X_in
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));

  equation
    connect(p_in, p_in_internal);
    connect(h_in, h_in_internal);
    connect(X_in, X_in_internal);

    if not use_p_in then
      p_in_internal = p;
    end if;
    if not use_h_in then
      h_in_internal = h;
    end if;

    if not use_X_in then
      X_in_internal = X;
    end if;

    portMoistAir_a.p = p_in_internal;
    portMoistAir_a.h_outflow = h_in_internal;
    portMoistAir_a.X_outflow = X_in_internal;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                 graphics={
            Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={170,255,255},
            fillPattern=FillPattern.Sphere,
            fillColor={170,213,255}), Text(
            extent={{-66,14},{76,-10}},
            lineColor={0,0,255},
            textString="p boundary")}),
               Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Boundary Model for Moist Air. Defines absolute pressure, specific enthalpy per mass dry air and water fraction per mass dry air.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer\">AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer</a></p>
</html>",   revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end BoundaryMoistAir_phX;

  model MassflowsourceMoistAir_mhX
    "boundary for Moist Air, massflow, enthalpy, water fraction"
    outer BaseParameters baseParameters "System properties";

    parameter Boolean use_m_in = false
      "Get the massflow of dry air from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_h_in= false
      "Get the specific enthalpy per mass dry air from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));
    parameter Boolean use_X_in= false
      "Get the water mass fraction per mass dry air from the input connector"
      annotation(Evaluate=true, HideResult=true, choices(__Dymola_checkBox=true));

    parameter Modelica.SIunits.MassFlowRate m = 0.01
      "Fixed value of mass flow of dry air "
      annotation (Evaluate = true,
                  Dialog(enable = not use_p_in));
    parameter Modelica.SIunits.SpecificEnthalpy h = 1e4
      "Fixed value of specific enthalpy per mass dry air"
      annotation (Evaluate = true,
                  Dialog(enable = not use_h_in));

  parameter Real X(min=0,max=1) = 2e-3
      "Fixed value of water mass fraction per mass dry air "
      annotation (Evaluate = true,
                  Dialog(enable = not use_X_in));

  protected
    Modelica.Blocks.Interfaces.RealInput m_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput h_in_internal
      "Needed to connect to conditional connector";
    Modelica.Blocks.Interfaces.RealInput X_in_internal
      "Needed to connect to conditional connector";

  public
    Interfaces.PortMoistAir_a
                      portMoistAir_a
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.RealInput m_in if use_m_in
      annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
    Modelica.Blocks.Interfaces.RealInput h_in if use_h_in
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput X_in if use_X_in
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));

  equation
    connect(m_in, m_in_internal);
    connect(h_in, h_in_internal);
    connect(X_in, X_in_internal);

    if not use_m_in then
      m_in_internal = m;
    end if;
    if not use_h_in then
      h_in_internal = h;
    end if;

    if not use_X_in then
      X_in_internal = X;
    end if;

    portMoistAir_a.m_flow = -m_in_internal;
    portMoistAir_a.h_outflow = h_in_internal;
    portMoistAir_a.X_outflow = X_in_internal;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                 graphics={
            Ellipse(
            extent={{-100,100},{100,-100}},
            lineColor={170,255,255},
            fillPattern=FillPattern.Sphere,
            fillColor={170,213,255}), Text(
            extent={{-68,12},{74,-12}},
            lineColor={0,0,255},
            textString="m_flow boundary")}),
               Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Boundary Model for Moist Air. Defines mass flow of dry air, specific enthalpy per mass dry air and water fraction per mass dry air.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer\">AixLib.HVAC.Volume.Examples.MoistAirWithHeatTransfer</a></p>
</html>",   revisions="<html>
<p>10.12.2013, Mark Wesseling</p>
<p><ul>
<li>implemented</li>
</ul></p>
</html>"));
  end MassflowsourceMoistAir_mhX;
end Sources;
