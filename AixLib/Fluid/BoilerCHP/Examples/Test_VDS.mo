within ;
package Test_VDS
  model boiler

    AixLib.Fluid.BoilerCHP.Boiler boiler "H02.1"
      annotation (Placement(transformation(extent={{0,52},{20,72}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{90,52},{110,72}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a1
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-110,52},{-90,72}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort SEN_T "B01_WS.H.SUP.PRIM_MEA.T_AI"
      annotation (Placement(transformation(extent={{-58,52},{-38,72}})));
    AixLib.Fluid.Sensors.TemperatureTwoPort SEN_T1 "B06_WS.H.RET.PRIM_MEA.T_AI"
      annotation (Placement(transformation(extent={{42,52},{62,72}})));
  equation
    connect(port_a1, SEN_T.port_a) annotation (Line(points={{-100,62},{-79,62},
            {-58,62}}, color={0,127,255}));
    connect(SEN_T.port_b, boiler.port_a)
      annotation (Line(points={{-38,62},{0,62}}, color={0,127,255}));
    connect(boiler.port_b, SEN_T1.port_a)
      annotation (Line(points={{20,62},{32,62},{42,62}}, color={0,127,255}));
    connect(SEN_T1.port_b, port_b1)
      annotation (Line(points={{62,62},{82,62},{100,62}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end boiler;

  model Gesamtmodell
    boiler boiler_system "4120//BOI-H02.1"
      annotation (Placement(transformation(extent={{-24,8},{-4,28}})));
    AixLib.Fluid.Sources.FixedBoundary bou(nPorts=1)
      annotation (Placement(transformation(extent={{-68,12},{-48,32}})));
    AixLib.Fluid.Sources.FixedBoundary bou1(nPorts=1)
      annotation (Placement(transformation(extent={{54,12},{34,32}})));
  equation
    connect(bou.ports[1], boiler_system.port_a1) annotation (Line(points={{-48,
            22},{-42,22},{-42,24.2},{-24,24.2}}, color={0,127,255}));
    connect(boiler_system.port_b1, bou1.ports[1]) annotation (Line(points={{-4,
            24.2},{4,24.2},{4,22},{34,22}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Gesamtmodell;
  annotation (uses(AixLib(version="0.5.2"), Modelica(version="3.2.2")));
end Test_VDS;
