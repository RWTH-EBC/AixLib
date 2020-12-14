within AixLib.Utilities.Logical;
model ValveControlLogicSimpleSum "Controls a valve"

  Modelica.Blocks.Interfaces.RealOutput val_pos "position of the valve"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-420,-100}), iconTransformation(
        extent={{-20,20},{20,-20}},
        rotation=-90,
        origin={-360,-100})));
  Modelica.Blocks.Interfaces.RealInput dT_Network "dT Network" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-480,100}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-480,100})));
  Modelica.Blocks.Interfaces.RealInput return_temp
    "Signal of the Netork Return Temperature"     annotation (Placement(
        transformation(extent={{-220,20},{-260,60}}),     iconTransformation(
          extent={{-220,20},{-260,60}})));
  Modelica.Blocks.Interfaces.RealInput supply_temp
    "Signal of the Network Supply Temperature"    annotation (Placement(
        transformation(extent={{-220,-60},{-260,-20}}),   iconTransformation(
          extent={{-220,-60},{-260,-20}})));
  Modelica.Blocks.Logical.LessThreshold cooling
    "more heat added to the pipe than taken out" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-478,30})));
  Modelica.Blocks.Math.Add heat_ret(k1=-1)
    annotation (Placement(transformation(extent={{-420,60},{-400,40}})));
  Modelica.Blocks.Math.Add cold_ret(k1=+1)
    "desired return temperature of the network pipe in cooling mode"
    annotation (Placement(transformation(extent={{-420,0},{-400,20}})));
  Modelica.Blocks.Continuous.LimPID pControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.002,
    Ti=7,
    Td=0.1,
    yMax=1,
    yMin=0.1,
    initType=Modelica.Blocks.Types.InitPID.InitialOutput,
    y_start=0.3)      "Pressure controller" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-338,30})));
  Modelica.Blocks.Logical.Switch T_HP_supply1 "return Temp of the Network"
                                        annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-372,30})));
  Modelica.Blocks.Math.Add3    hx_bigger_hp(k1=-1)
    "the heat added to the network by the heat exchanger is vbigger than the heat taken from the nwtowkr by the condensor"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-510,30})));
  Modelica.Blocks.Interfaces.RealInput dhw_input annotation (Placement(
        transformation(extent={{-580,-80},{-540,-40}}), iconTransformation(
          extent={{-580,-80},{-540,-40}})));
  Modelica.Blocks.Interfaces.RealInput heat_input "densor" annotation (
      Placement(transformation(extent={{-580,-20},{-540,20}}),
        iconTransformation(extent={{-580,-20},{-540,20}})));
  Modelica.Blocks.Interfaces.RealInput cold_input annotation (Placement(
        transformation(extent={{-580,40},{-540,80}}), iconTransformation(extent=
           {{-580,40},{-540,80}})));
equation
  connect(cooling.y,T_HP_supply1. u2) annotation (Line(points={{-467,30},{-384,
          30}},             color={255,0,255}));
  connect(heat_ret.y,T_HP_supply1. u3) annotation (Line(points={{-399,50},{-392,
          50},{-392,38},{-384,38}},       color={0,0,127}));
  connect(cold_ret.y,T_HP_supply1. u1) annotation (Line(points={{-399,10},{-390,
          10},{-390,22},{-384,22}},       color={0,0,127}));
  connect(T_HP_supply1.y,pControl. u_s)
    annotation (Line(points={{-361,30},{-350,30}},   color={0,0,127}));
  connect(pControl.y, val_pos) annotation (Line(points={{-327,30},{-318,30},{
          -318,-60},{-420,-60},{-420,-100}}, color={0,0,127}));
  connect(heat_ret.u2, supply_temp) annotation (Line(points={{-422,56},{-440,56},
          {-440,-40},{-240,-40}}, color={0,0,127}));
  connect(cold_ret.u1, supply_temp) annotation (Line(points={{-422,16},{-440,16},
          {-440,-40},{-240,-40}}, color={0,0,127}));
  connect(heat_ret.u1, dT_Network) annotation (Line(points={{-422,44},{-432,44},
          {-432,62},{-480,62},{-480,100}}, color={0,0,127}));
  connect(cold_ret.u2, dT_Network) annotation (Line(points={{-422,4},{-432,4},{
          -432,62},{-480,62},{-480,100}}, color={0,0,127}));
  connect(pControl.u_m, return_temp) annotation (Line(points={{-338,42},{-338,
          58},{-286,58},{-286,40},{-240,40}}, color={0,0,127}));
  connect(dhw_input, hx_bigger_hp.u3) annotation (Line(points={{-560,-60},{-530,
          -60},{-530,22},{-522,22}}, color={0,0,127}));
  connect(heat_input, hx_bigger_hp.u2) annotation (Line(points={{-560,0},{-534,
          0},{-534,30},{-522,30}}, color={0,0,127}));
  connect(cold_input, hx_bigger_hp.u1) annotation (Line(points={{-560,60},{-532,
          60},{-532,38},{-522,38}}, color={0,0,127}));
  connect(hx_bigger_hp.y, cooling.u)
    annotation (Line(points={{-499,30},{-490,30}}, color={0,0,127}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-540,
            -80},{-260,80}}),  graphics={Rectangle(
          extent={{-540,80},{-260,-80}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
                              Text(
          extent={{-522,64},{-280,-62}},
          lineColor={0,0,0},
          textString="Simple
Sum"),                                         Text(
          extent={{-460,120},{-260,80}},
          lineColor={0,0,255},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-540,-80},{-260,80}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br>Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end ValveControlLogicSimpleSum;
