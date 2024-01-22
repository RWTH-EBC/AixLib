within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses;
package HeatPump_Sources
  model Liquid
     extends AixLib.Fluid.Interfaces.PartialTwoPort(redeclare package Medium =
                 AixLib.Media.Water);

    parameter Modelica.Units.SI.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
     annotation (Dialog(group="Nominal condition"));

      parameter Boolean TSourceInternal=true
                                            "Use internal TSource?"
      annotation (Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));

     parameter Modelica.Units.SI.Temperature TSource=TSourceNom "Temperature of heat source"
     annotation (Dialog(enable=TSourceInternal,tab="Advanced",group="General machine information"));

    replaceable package MediumEvap = AixLib.Media.Water
                                       constrainedby
      Modelica.Media.Interfaces.PartialMedium "Medium heat source"
        annotation (choices(
          choice(redeclare package Medium = AixLib.Media.Water "Water"),
          choice(redeclare package Medium =
              AixLib.Media.Antifreeze.PropyleneGlycolWater (
                property_T=293.15,
                X_a=0.40)
                "Propylene glycol water, 40% mass fraction")));

   parameter Modelica.Units.SI.TemperatureDifference DeltaTEvap=3 "Temperature difference heat source evaporator"
     annotation (Dialog(tab="Advanced",group="General machine information"));


    Fluid.Sources.Boundary_pT        bouEvap_b(redeclare package Medium =
          MediumEvap, nPorts=1)
      annotation (Placement(transformation(extent={{-38,-10},{-58,10}})));
    Fluid.Sources.MassFlowSource_T        bouEvap_a(
      redeclare package Medium = MediumEvap,
      use_m_flow_in=true,
      m_flow=1,
      use_T_in=true,
      T=306.15,
      nPorts=1) annotation (Placement(transformation(extent={{16,14},{44,-14}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-10,50})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=TSourceInternal)
      annotation (Placement(transformation(extent={{-100,38},{-48,62}})));
    Modelica.Blocks.Sources.RealExpression tSource(y=TSource)
                                                          "TSource"
      annotation (Placement(transformation(extent={{-86,18},{-54,42}})));
    Modelica.Blocks.Math.Division division1
      annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
    Modelica.Blocks.Sources.RealExpression mFlowEva(y=MediumEvap.cp_const*
          DeltaTEvap) "massflow heat source"
      annotation (Placement(transformation(extent={{98,-68},{56,-44}})));
    AixLib.Controls.Interfaces.VapourCompressionMachineControlBus sigBus annotation (
        Placement(transformation(extent={{-18,84},{18,116}}), iconTransformation(
            extent={{-16,88},{18,118}})));
    AixLib.Controls.Continuous.LimPID conPID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=20,
      yMax=1,
      Td=1,
      yMin=0.1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=1)
      annotation (Placement(transformation(extent={{-66,-68},{-46,-48}})));
    Modelica.Blocks.Math.Add add(k2=-1)
      annotation (Placement(transformation(extent={{-130,-68},{-110,-48}})));
    Modelica.Blocks.Sources.RealExpression mFlowEva1(y=3)
                      "massflow heat source"
      annotation (Placement(transformation(extent={{-172,-76},{-148,-52}})));
    Modelica.Blocks.Math.Gain gain
      annotation (Placement(transformation(extent={{-90,-90},{-78,-78}})));
    Modelica.Blocks.Math.Gain gain1
      annotation (Placement(transformation(extent={{-94,-64},{-82,-52}})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-6,-48},{-26,-28}})));
    Modelica.Blocks.Sources.RealExpression zero(y=0.1)
                                                     annotation (Placement(
          transformation(
          extent={{-12,-12},{12,12}},
          rotation=0,
          origin={-38,-96})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{4,-96},{24,-76}})));
  equation
    connect(port_a, bouEvap_b.ports[1])
      annotation (Line(points={{-100,0},{-58,0}}, color={0,127,255}));
    connect(bouEvap_a.ports[1], port_b)
      annotation (Line(points={{44,0},{100,0}}, color={0,127,255}));
    connect(mFlowEva.y, division1.u2)
      annotation (Line(points={{53.9,-56},{42,-56}}, color={0,0,127}));
    connect(booleanExpression.y, switch1.u2)
      annotation (Line(points={{-45.4,50},{-22,50}}, color={255,0,255}));
    connect(tSource.y, switch1.u1) annotation (Line(points={{-52.4,30},{-32,30},{-32,
            42},{-22,42}}, color={0,0,127}));
    connect(switch1.y, bouEvap_a.T_in) annotation (Line(points={{1,50},{16,50},{16,
            16},{0,16},{0,-5.6},{13.2,-5.6}}, color={0,0,127}));
    connect(sigBus.QEvapNom, division1.u1) annotation (Line(
        points={{0.09,100.08},{0.09,80},{62,80},{62,-44},{42,-44}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(division1.y, product1.u1) annotation (Line(points={{19,-50},{12,-50},
            {12,-32},{-4,-32}}, color={0,0,127}));
    connect(product1.y, bouEvap_a.m_flow_in) annotation (Line(points={{-27,-38},
            {-32,-38},{-32,-11.2},{13.2,-11.2}}, color={0,0,127}));
    connect(switch1.y, add.u1) annotation (Line(points={{1,50},{4,50},{4,16},{
            -50,16},{-50,14},{-132,14},{-132,-52}},
                                              color={0,0,127}));
    connect(sigBus.TSourceSet, switch1.u3) annotation (Line(
        points={{0.09,100.08},{0,100.08},{0,80},{-36,80},{-36,58},{-22,58}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(conPID.y, switch2.u1) annotation (Line(points={{-45,-58},{-30,-58},
            {-30,-78},{2,-78}}, color={0,0,127}));
    connect(switch2.y, product1.u2) annotation (Line(points={{25,-86},{34,-86},
            {34,-64},{4,-64},{4,-44},{-4,-44}}, color={0,0,127}));
    connect(zero.y, switch2.u3) annotation (Line(points={{-24.8,-96},{-12,-96},
            {-12,-94},{2,-94}}, color={0,0,127}));
    connect(sigBus.OnOff, switch2.u2) annotation (Line(
        points={{0.09,100.08},{2,100.08},{2,58},{138,58},{138,-86},{2,-86}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sigBus.TEvaOutMea, gain.u) annotation (Line(
        points={{0.09,100.08},{2,100.08},{2,-12},{-94,-12},{-94,-84},{-91.2,-84}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(gain.y, conPID.u_m) annotation (Line(points={{-77.4,-84},{-68,-84},
            {-68,-86},{-56,-86},{-56,-70}}, color={0,0,127}));
    connect(mFlowEva1.y, add.u2)
      annotation (Line(points={{-146.8,-64},{-132,-64}}, color={0,0,127}));
    connect(add.y, gain1.u)
      annotation (Line(points={{-109,-58},{-95.2,-58}}, color={0,0,127}));
    connect(gain1.y, conPID.u_s)
      annotation (Line(points={{-81.4,-58},{-68,-58}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Ellipse(
            extent={{-74,78},{74,-78}},
            lineColor={28,108,200},
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid), Line(
            points={{-4,62},{-14,44},{-34,18},{-36,-10},{-32,-32},{-16,-48},{2,-58},
                {22,-52},{32,-42},{42,-24},{36,-8},{28,2},{20,12},{14,24},{12,38},
                {12,42},{10,58},{10,72},{-4,62}},
            color={255,255,255},
            smooth=Smooth.Bezier)}),                               Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Liquid;
end HeatPump_Sources;
