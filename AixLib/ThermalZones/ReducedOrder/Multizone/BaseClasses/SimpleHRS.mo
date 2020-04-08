within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model SimpleHRS

parameter Real pinchT=2;
parameter Real etaHRS= 0.9;
parameter Integer nZones=2;
parameter Real shareVolume[nZones];
parameter Real totalVolume[nZones];
Modelica.Blocks.Interfaces.RealOutput Tinlet[nZones]
  annotation (Placement(transformation(extent={{100,-16},{130,14}})));

Modelica.Blocks.Interfaces.RealInput Tair[nZones]
    annotation (Placement(transformation(extent={{-120,50},{-80,90}})));
  Modelica.Blocks.Interfaces.RealInput mixedTemp
    annotation (Placement(transformation(extent={{-116,-86},{-86,-56}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{28,-22},{48,-2}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-6,-20},{14,0}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=nZones)
    annotation (Placement(transformation(extent={{60,-24},{80,-4}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=(mixedTemp - Tair[1])
        *etaHRS + Tair[1])
    annotation (Placement(transformation(extent={{-60,-64},{-40,-44}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    uLow=273.15 + 12,
    uHigh=273.15 + 24,
    pre_y_start=false)
    annotation (Placement(transformation(extent={{-50,24},{-30,44}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1(
    uLow=273.15 + 19,
    uHigh=273.15 + 24,
    pre_y_start=false)
    annotation (Placement(transformation(extent={{-52,-22},{-32,-2}})));
equation

//    if noEvent(Tair[1] < (273.15+24)) and noEvent(Tair[1] > (273.15+20)) then
//     Tinlet = Tair;
//    else
//      Tinlet = (mixedTemp*ones(nZones) - Tair)*etaHRS + Tair;
//    end if;




// Tinlet = (mixedTemp* - Tair[1])*etaHRS + Tair[1]
  connect(replicator.y, Tinlet) annotation (Line(points={{81,-14},{92,-14},{92,-1},
          {115,-1}}, color={0,0,127}));
  connect(switch1.y, replicator.u) annotation (Line(points={{49,-12},{52,-12},{52,
          -14},{58,-14}}, color={0,0,127}));
  connect(and1.y, switch1.u2) annotation (Line(points={{15,-10},{20,-10},{20,-12},
          {26,-12}}, color={255,0,255}));
  connect(Tair[1], switch1.u1) annotation (Line(points={{-100,60},{-68,60},{-68,
          94},{20,94},{20,-4},{26,-4}}, color={0,0,127}));
  connect(realExpression.y, switch1.u3) annotation (Line(points={{-39,-54},{10,
          -54},{10,-20},{26,-20}}, color={0,0,127}));
  connect(Tair[1], hysteresis.u) annotation (Line(points={{-100,60},{-66,60},{
          -66,34},{-52,34}}, color={0,0,127}));
  connect(mixedTemp, hysteresis1.u) annotation (Line(points={{-101,-71},{-101,
          -41.5},{-54,-41.5},{-54,-12}}, color={0,0,127}));
  connect(hysteresis.y, and1.u1) annotation (Line(points={{-29,34},{-18,34},{
          -18,-10},{-8,-10}}, color={255,0,255}));
  connect(hysteresis1.y, and1.u2) annotation (Line(points={{-31,-12},{-18,-12},
          {-18,-18},{-8,-18}}, color={255,0,255}));
annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
      coordinateSystem(preserveAspectRatio=false)));
end SimpleHRS;
