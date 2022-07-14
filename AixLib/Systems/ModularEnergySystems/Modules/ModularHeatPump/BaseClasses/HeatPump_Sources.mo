within AixLib.Systems.ModularEnergySystems.Modules.ModularHeatPump.BaseClasses;
package HeatPump_Sources
  model Liquid
     extends AixLib.Fluid.Interfaces.PartialTwoPort(redeclare package
        Medium = AixLib.Media.Water);

    parameter Modelica.Units.SI.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
     annotation (Dialog(group="Nominal condition"));

      parameter Boolean TSourceInternal=true
                                            "Use internal TSource?"
      annotation (choices(checkBox=true), Dialog(descriptionLabel=true, tab="Advanced",group="General machine information"));

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
    Interfaces.VapourCompressionMachineControleBusModular
      sigBus annotation (Placement(transformation(extent={{-14,82},{16,116}}),
          iconTransformation(extent={{-8,90},{10,116}})));
  equation
    connect(port_a, bouEvap_b.ports[1])
      annotation (Line(points={{-100,0},{-58,0}}, color={0,127,255}));
    connect(bouEvap_a.ports[1], port_b)
      annotation (Line(points={{44,0},{100,0}}, color={0,127,255}));
    connect(mFlowEva.y, division1.u2)
      annotation (Line(points={{53.9,-56},{42,-56}}, color={0,0,127}));
    connect(division1.y, bouEvap_a.m_flow_in) annotation (Line(points={{19,-50},{0,
            -50},{0,-11.2},{13.2,-11.2}}, color={0,0,127}));
    connect(booleanExpression.y, switch1.u2)
      annotation (Line(points={{-45.4,50},{-22,50}}, color={255,0,255}));
    connect(tSource.y, switch1.u1) annotation (Line(points={{-52.4,30},{-32,30},{-32,
            42},{-22,42}}, color={0,0,127}));
    connect(switch1.y, bouEvap_a.T_in) annotation (Line(points={{1,50},{16,50},{16,
            16},{0,16},{0,-5.6},{13.2,-5.6}}, color={0,0,127}));
    connect(sigBus.TSource, switch1.u3) annotation (Line(
        points={{1,99},{1,88},{-28,88},{-28,58},{-22,58}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(sigBus.QEvapNom, division1.u1) annotation (Line(
        points={{1.075,99.085},{1.075,88},{72,88},{72,-44},{42,-44}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
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
