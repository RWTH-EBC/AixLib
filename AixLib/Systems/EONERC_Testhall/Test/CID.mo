within AixLib.Systems.EONERC_Testhall.Test;
model CID
  BaseClass.CID cID
    annotation (Placement(transformation(extent={{-48,-22},{46,34}})));
  Fluid.Sources.Boundary_pT ret_water(
    redeclare package Medium = AixLib.Media.Water,
    use_T_in=false,
    nPorts=1)
    annotation (Placement(transformation(extent={{-38,-60},{-24,-46}})));
  Fluid.Sources.Boundary_pT sup_water(
    redeclare package Medium = AixLib.Media.Water,
    p=172000,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{8,-60},{-6,-46}})));
  Fluid.Sources.Boundary_pT sup_air(
    redeclare package Medium = AixLib.Media.Air,
    p=102420,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{54,-42},{40,-28}})));
  Fluid.Sources.Boundary_pT ret_air(
    redeclare package Medium = AixLib.Media.Air,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{-36,28},{-22,42}})));
  Modelica.Blocks.Sources.Constant AirValve(k=0.2) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-80,2})));
  BaseClass.DistributeBus distributeBus annotation (Placement(transformation(
          extent={{-54,-8},{-36,12}}), iconTransformation(extent={{-54,-8},{-36,
            12}})));
  Modelica.Blocks.Sources.Constant Valve(k=0.3) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-82,-18})));
  Modelica.Blocks.Sources.Constant rpm(k=1250) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-82,-40})));
equation
  connect(sup_water.ports[1], cID.cid_supprim) annotation (Line(points={{-6,-53},
          {-6,-52},{-8.74118,-52},{-8.74118,-16.4}}, color={0,127,255}));
  connect(ret_water.ports[1], cID.cid_retprim) annotation (Line(points={{-24,
          -53},{-16.4824,-53},{-16.4824,-16.4}}, color={0,127,255}));
  connect(sup_air.ports[1], cID.air_in) annotation (Line(points={{40,-35},{
          10.6118,-35},{10.6118,-16.4}}, color={0,127,255}));
  connect(cID.air_out, ret_air.ports[1]) annotation (Line(points={{-14.8235,
          17.2},{-14.8235,36},{-22,36},{-22,35}}, color={0,127,255}));
  connect(distributeBus, cID.distributeBus_CID) annotation (Line(
      points={{-45,2},{-38.3029,2},{-38.3029,0.12},{-25.6059,0.12}},
      color={255,204,51},
      thickness=0.5));
  connect(AirValve.y, distributeBus.bus_cid.Office_Air_Valve) annotation (Line(
        points={{-73.4,2},{-60,2},{-60,2.05},{-44.955,2.05}}, color={0,0,127}));
  connect(Valve.y, distributeBus.bus_cid.valveSet) annotation (Line(points={{
          -75.4,-18},{-58,-18},{-58,2.05},{-44.955,2.05}}, color={0,0,127}));
  connect(rpm.y, distributeBus.bus_cid.pumpBus.rpmSet) annotation (Line(points=
          {{-75.4,-40},{-44.955,-40},{-44.955,2.05}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CID;
