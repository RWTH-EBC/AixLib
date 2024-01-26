within AixLib.Systems.EONERC_Testhall;
package Subsystems
  package ConcreteCoreActivation
    model CCASystem

      HydraulicModules.Injection2WayValve injection(
        redeclare package Medium = AixLib.Media.Water,
        pipeModel="SimplePipe",
        length=1,
        Kv=15,
        m_flow_nominal=m_flow_nominal,
        vol=0.005,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN50_H1_10()),
        pipe1(length=0.3),
        pipe2(length=0.2),
        pipe3(length=10, fac=10),
        pipe4(length=10),
        pipe6(length=0.2),
        pipe5(length=0.5, nNodes=1),
        T_amb=273.15 + 10,
        T_start=T_start_hydraulic,
        pipe7(length=0.2)) annotation (Dialog(enable=true),Placement(transformation(
            extent={{-30.0001,-30.0001},{29.9999,29.9999}},
            rotation=90,
            origin={-0.0001,-29.9999})));

      BaseClasses.CCA.ConcreteCoreActivation concreteCoreActivation(
        area=700,
        thickness=0.2,
        alpha=150,
        pipe(
          length=1500,
          hCon=10,
          m_flow_nominal=m_flow_nominal,
          nNodes=1,
          T_start=295.15),
        m_flow_nominal=m_flow_nominal,
        T_start_hydraulic=T_start_hydraulic,
        T_start=T_start)
        annotation (Dialog(enable=true),Placement(transformation(extent={{-20,40},{20,80}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{
                -30,-110},{-10,-90}}), iconTransformation(extent={{-40,-110},{
                -20,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{
                10,-110},{30,-90}}), iconTransformation(extent={{20,-112},{40,
                -92}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_port_CCA
        annotation (Placement(transformation(extent={{-10,90},{10,110}}),
            iconTransformation(extent={{-10,90},{10,110}})));
      BaseClasses.Interfaces.CCABus ccaBus annotation (Placement(transformation(
              extent={{-120,-20},{-80,20}}), iconTransformation(extent={{-120,
                -20},{-80,20}})));
      parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.8
        "Nominal mass flow rate";
      parameter Modelica.Units.SI.Temperature T_start_hydraulic=323.15
        "Initialization temperature" annotation (Dialog(tab="Initialization"));
      parameter Modelica.Units.SI.Temperature T_start=293.15
        "Initialization temperature of capacity"
        annotation (Dialog(tab="Initialization"));
    equation
      connect(port_a, injection.port_a1) annotation (Line(points={{-20,-100},{-20,-81},
              {-18,-81},{-18,-60}}, color={0,127,255}));
      connect(port_b, injection.port_b2) annotation (Line(points={{20,-100},{20,-81},
              {18,-81},{18,-60}}, color={0,127,255}));
      connect(injection.port_a2, concreteCoreActivation.port_b) annotation (Line(
            points={{18,0},{18,30},{40,30},{40,60},{20,60}}, color={0,127,255}));
      connect(concreteCoreActivation.heatPort, heat_port_CCA)
        annotation (Line(points={{0,80},{0,100}},       color={191,0,0}));
      connect(injection.port_b1, concreteCoreActivation.port_a) annotation (Line(
            points={{-18,0},{-18,30},{-40,30},{-40,60},{-20,60}}, color={0,127,255}));
      connect(injection.hydraulicBus, ccaBus.hydraulicBus) annotation (Line(
          points={{-30,-30},{-61,-30},{-61,0.1},{-99.9,0.1}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(concreteCoreActivation.TConcrete, ccaBus.coreTemp) annotation (
          Line(points={{22,74.4},{36,74.4},{36,88},{-100,88},{-100,0.1},{-99.9,
              0.1}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      annotation (Icon(                                             graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={212,212,212},
              fillPattern=FillPattern.Solid),
            Bitmap(
              extent={{-30,14},{30,74}},
              imageSource=
                  "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F4A+4QWg9XKaelsR3pyXmU27AHnIJb4m3gqJLkBecoiv8FZEdAHyVHd8Gx/eHJeZRReAYUy8cya6APmrc+oV3jkSXYDmqCu+jQ5vjsvMADRHHfE18QLQaanjK7wAkFBjw5vbMrPruwDNlXLqNfECwINSxVd4ASChRoY3t2VmANohxdRr4gWAhIR3DmysAmBSjQuvZWYAqlT1crOJFwASEl4ASEh4AWCJKpebGxXeHK/v2lgFwEqYeAEgIeEFgAGqWm5uTHjdRgRAG5h4ASAh4Z2BjVUA7VbFcrPwAkBCjQiv67sAtIWJFwBGmPdys/ACQELZhzfXZWYbqwCYhokXAMaY53Kz8AJAQsILAAllHV63EQGQi3ktN5t4ASAh4QWAhLINr2VmAHIzj+VmEy8AJCS8AJCQ8ALACsy63JxleF3fBaCtTLwAkJDwAsAKzbLcnF14LTMD0GYmXgBISHgBICHhBYCE1lpYWHigfF27Jl3fPezwQ3sX12muBx54oLj55puLa6+9tvfP9ddfX9xxxx3F3XffXdx11129n99ggw2K9ddfv/fPFltsUWy//fbFdtttVzzxiU8sf5X8tPW8IDer9tijWL2wUB5NTninJLzNFNFZvXp1cfHFFxeXXHJJcdNNN5U/szKbbrpp8ZKXvKTYb7/9sohVW8+r77jjjuud2zDHHHNM8aIXvag8gjSENzHhbZb//Oc/xYUP/vc666yziuuuu658d3Zrr7128fznP79429veVmy55Zblu+m09bwW+9vf/lYceOCBvXMdZscHv3Z89rOfLY8gjWnDm801XrcRUZWYAA899NDihBNOmGucwn//+9/i0ksvLd74xjcWp556avGvf/2r/JnqtfW8ljr//PNHRjc8OEDM/fcAqmJzFa0Vk9Lxxx9fHHvssb1rnlX697//XZxxxhnFW97ylsr/f7X1vAaJJfRzzz23PBrtW9/6VvkK8ia8tNJVV11VHH744b1l2JR+//vfF0cccUTx29/+tnxnvtp6XsNcffXVxQ033FAejfaDH/yguOeee8ojyFc213ibttTsGm++Lr/88t5EOOny6GabbVZsu+22xTbbbFM85SlP6e30XW+99Xo/F7uA//73v/eCE5uXInyxDDvOYx7zmOJjH/tY79rjvLT1vEY5+eSTi+9+97vl0cMe/ehHF/fdd1959LCjjjqq2H///csjqFajN1c18fqu8Obpxz/+cS9O4yISAdpnn316u3ef8YxnlO+Od9ttt/WWPr/+9a8Xd955Z/nuYBtvvHFxyimnFJtsskn5zvTael6j/POf/ywOOOCAZVNsxP/lL395cfbZZ5fvPGyrrbYqvvjFLxZrrbVW+Q5Up/Gbq2BW11xzTXHiiSeOjFN8QY4v2meeeWbxzne+c0VxCnGLzetf//redc8Xv/jF5buD3X777cWHPvSh4v777y/fmU5bz2uciy66aODScUzbe++9d3m0pthgFRM85Ex4aYXYcBT3csaUNMyGG25YfOpTnyre8573FBtttFH57nTi13r/+99fHHnkkeU7g8Vu26985Svl0cq19bwm8f3vf798taaddtqp943FU5/61PKdNdlkRe6El1aI8Nx6663l0XJxL+oXvvCF3hfteYr7SyN4o0SgIqDTaOt5jfPHP/6xuPLKK8ujNcW5xoS/5557lu+sKTaexZO6IFe1h9f9u8zqZz/72chdvk94whN6m3Rig1EVYok3nvY0zL333lucdtpp5dHk2npekzjvvPPKV2t61KMe1dswFl74whf2flwqlsAnvQUJ6mDipdHii2xMhcPEF+qTTjqpeNKTnlS+U424rvrkJz+5PFoudub+5S9/KY/Ga+t5TSIeljEsvLvsskuxzjrr9F4/7WlPK57+9Kf3Xi/17W9/e6Jd2lAH4aXRfvSjH/WWJYc55JBDVrzRaBrrrrtu7ylPw0QELrjggvJovLae1yRi0h8W81WrVpWvHrLXXnuVr9b0pz/9qbjiiivKI8iL8NJY8VSjuP1lmLiP9eCDDy6PqhcP6Y8pbJiY4uLfeZy2ntekhm2qiudH77bbbuXRQ4Zd5w02WZEr4aWx4raRUU9SOuigg3oPWkglwhDXRYeJ+2NHbZTqa+t5TSIe6nHZZZeVR2vaeeedi8c97nHl0UNiZ/PWW29dHq0pfp24PxlyI7w0Vjw8f5h4yEI8SCK1uL/0kY98ZO91fM5tPMgibs+J+2vPOeeckddL+9p6XpOIxz7G86EHWbrM3DdsuTmWwQc99QrqJrw0Uixt/uQnPymPlouPtHvsYx9bHqUT98F+4hOfKL75zW/2HkZx9NFH9x5Isfnmm0/0NKW2ntck4ty/973vlUdriugPC++o5eYI77CQQ11qDa9biZhWPLT/lltuKY+Wi2XJusR9po9//OPLo5Vp63lNYtQHIuy66669+A8S0/Yzn/nM8mhNf/3rX4cuXUNdTLw0Uux8HWXYF+LctfW8JjHq3ttxj7Ec9fM2WZEb4aWRfve735WvlouH9w97nGDu2npe48QjMX/4wx+WR2uKKfs5z3lOeTRYLEPHrU+DxG1Fo27NgtSEl0aKJdlhYiqc13XH1Np6XuPEpy/dfffd5dGa4nam/sauYWLT2ahrvfFADciF8NI4sQnnxhtvLI+WG3Z7Se7ael6TGHbvbth3333LV6ONWm6OZexJP8cYqia8NE5MRv/4xz/Ko+WqenZx1dp6XuPEU6Z+9atflUdrim824jN2JxGbv+LhIoPE72s8DQxyILw0zrAlyb6qn19clbae1zizbKpaLJbhR/3vLTeTi9rC61YipjXow9EX22CDDcpXzdLW8xolHnIxLLxxXXfYJxANE8vSw66DX3XVVcW1115bHkF9TLw0zrhADdvdmru2ntcooz4QYdS9u8PEPb2j7nV2axE5EF4aZ9wmmfjIvCZq63mNMmpT1UqWmRcb9RnC8UjKcUv6UDXhpXHGTX733Xdf+apZ2npew9xxxx3FpZdeWh6taZJ7d4d5wQteMPSxmnG/8KhnYUMKwkvjjAtUU28baet5DTPqAxEmuXd3mPh9HPdxgXHrFtRFeGmceFjCKDHVNFFbz2uQCN887t0dZtRyczwPemFhoTyC9ISXxln6maxLxYPxm6it5zVIfN7wsMdjruTe3WF22GGHkY/XtMmKOq314Hd+yddc2nAr0WGHH1pcdOGF5RGpveIVr+h9aPogRx11VLH//vuXR83S1vNaKj5icNh9tXGNdvfddy+PpnfBBRcM/YjF2Kj2ta99rdhoo43Kd2DlVu2xR7F6itUT4Z2S8NbryCOPHLpcePDBBxdvfetby6Nmaet5LRZL5q985Str310cv5fxewrTmja8lppppFHLiKM+4Sd3bT2vxS6++OIsbun5zne+03uAB6QmvDTSdtttV75aLp5QVPeu1Wl3ILf1vBYbtakqpZtvvnns5x9DFYSXRhr1gfB33nlnrZ+/evvttxcvfelLi7e//e3FKaec0vvifu+995Y/O1pbz6svPhDhl7/8ZXlUP89vpg7CSyNtueWWvYcsDHPZZZeVr9L76U9/2rs/dfXq1cWZZ55ZvO997yte9rKX/S9Yo5ZZ23pefeedd175Kg+XX355ccstt5RHkIbNVVOyuap+H/3oR3sPYRhk++23Lz7/+c+XR2l9+MMfHvoRdLGL9pxzzike8YhHlO8s19bziuupr371q4vbbrutfGdNseGqio8+jI8EPP3008uj5V73utcVb3rTm8ojmFxjdjW35VOJhLd+MYEdffTR5dFyX/7yl0duVqpCfJF/1ateNfRhFzEhvve97y2PBmvrecXSdEzJg8Q9zBHuKp5HHdfF3/zmNxfXXXdd+c6aNt544+Lss8+e+klZdJddzXTOLrvs0vuiOcxXv/rV8lU6sVN21BOmVq1aVb4arq3nNWpT1V577VXZh0DExwTGtelh4tr1JZdcUh5B9YSXxoplzXim7zBxPXHYR85V4f777y++8Y1vlEfLxefpjto81dfG84qNYaPits8++5SvqrH33nuPDLtNVqQkvDTaAQccMHSJMILx8Y9/PNktOGecccbIIMY1zEmnuradV1yzjn/vQWLZfNRtVPMQS9nxRKxhfvGLXxR/+MMfyiOolvDSaPHB5/vtt195tFzsWk1x32g8eziuvQ6z3nrrFQceeGB5NF6bziu+QRj17xrTfSwHV23U72fw/GZSEV4a75BDDhm5MeaTn/zk0Gf2zkNMg7Hjd9RTkGJj0vrrr18eTaYt53XNNdcM3dgURi2rz9OznvWs3jc0w8QS/qjr2DAvwkvjxRfTuCVkmLj39LjjjutNifMWcXr3u99d3HTTTeU7y22yySYrmnb72nJeo6bdHXfcsdhss83Ko2qtvfbaIz8u8K677hp6uxQsNe2O5pA0vG25lYj8HHrooSOvE953333FBz7wgeJzn/vc0GuNK3XllVf2Hh4x6tpgLKEec8wxK552+5p+XvGIyfiUoGGq3lS1VIR31LK25WZSMPFOKb6BiO94yEPsBP7gBz9YrLvuuuU7g8VHwR122GHF+eefP/UD8uNj+yJ073rXu8Y+9ei1r31tb4lzWk0/r/hAhJgkB4kNWXsk/jsUqwhxu9YwV199de+6NlRJeGmNLbbYojjxxBPH7rCN5wXH/y6myVNPPbW4/vrrx+4Qjmny17/+dXHyySf3rmtG6Mb93+y8887FG97whvJoek0+r1HLzM973vPGfvh/FWyyom6eXDUDT6/KUzzP+Nhjj13R5Bf3om6zzTa9642x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",
              fileName=
                  "modelica://AixLib/../../../../../13_Temp/Screenshot 2024-01-23 151511.png"),
            Rectangle(
              extent={{36,-98},{24,18}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-24,-100},{-36,16}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid)}),
        experiment(StopTime=100, __Dymola_Algorithm="Dassl"));
    end CCASystem;

    package Controls "Control components for the CCA"
      model ControlCCA
        "Information out of Unterlagen\\Heizlastberechnung\\Heizkurve_BKT"
        BaseClasses.Interfaces.CCABus distributeBus_CCA annotation (Placement(
              transformation(extent={{80,-20},{120,20}}), iconTransformation(
                extent={{80,-22},{120,20}})));
        Modelica.Blocks.Sources.Constant rpm_set(k=rpm_pump)
                                                         annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={30,30})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={50,70})));
        Modelica.Blocks.Continuous.LimPID PID_Valve(
          yMin=0,
          Td=0.5,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          yMax=1,
          Ti=Ti_valve,
          k=k_valve)
                   annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-10,-30})));

        BaseClasses.Controls.HeatCurve heatCurve(
          u_lower=u_lower,
          t_sup_upper=t_sup_upper,
          x=x,
          b=b) annotation (Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180,
              origin={-50,-30})));
        Modelica.Blocks.Interfaces.RealInput T_amb
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
              iconTransformation(extent={{-140,-20},{-100,20}})));
        parameter Real rpm_pump=3600 "Constant output value"
          annotation (Dialog(group="Pump"));
        parameter Real u_lower=14 "heating limit"
          annotation (Dialog(group="Heat Curve"));
        parameter Real t_sup_upper=48 "upper supply temperature limit"
          annotation (Dialog(group="Heat Curve"));
        parameter Real x=-0.5 "slope" annotation (Dialog(group="Heat Curve"));
        parameter Real b=24 "offset" annotation (Dialog(group="Heat Curve"));
        parameter Real k_valve=0.2 "Gain of controller"
          annotation (Dialog(group="Pump"));
        parameter Modelica.Units.SI.Time Ti_valve=2000
          "Time constant of Integrator block" annotation (Dialog(group="Pump"));
      equation
        connect(heatCurve.T_sup, PID_Valve.u_s)
          annotation (Line(points={{-37.9,-29.9},{-22,-29.9},{-22,-30}},
                                                          color={0,0,127}));
        connect(heatCurve.T_amb, T_amb) annotation (Line(points={{-62,-30},{-80,-30},{
                -80,0},{-120,0}},            color={0,0,127}));
        connect(rpm_set.y, distributeBus_CCA.hydraulicBus.pumpBus.rpmSet)
          annotation (Line(points={{41,30},{100,30},{100,16},{100.1,16},{100.1,
                0.1}}, color={0,0,127}));
        connect(booleanExpression1.y, distributeBus_CCA.hydraulicBus.pumpBus.onSet)
          annotation (Line(points={{61,70},{100.1,70},{100.1,0.1}}, color={255,
                0,255}));
        connect(PID_Valve.y, distributeBus_CCA.hydraulicBus.valveSet)
          annotation (Line(points={{1,-30},{60,-30},{60,0.1},{100.1,0.1}},
              color={0,0,127}));
        connect(PID_Valve.u_m, distributeBus_CCA.hydraulicBus.TFwrdOutMea)
          annotation (Line(points={{-10,-42},{-10,-60},{100.1,-60},{100.1,0.1}},
              color={0,0,127}));
        connect(heatCurve.T_sup, distributeBus_CCA.TSupSet) annotation (Line(
              points={{-37.9,-29.9},{-30,-29.9},{-30,0.1},{100.1,0.1}}, color={
                0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                  {100,100}}),                                        graphics={
              Text(
                extent={{-90,20},{56,-20}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                textString="HCMI"),
              Rectangle(
                extent={{-100,100},{100,-102}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Line(
                points={{20,100},{100,0},{20,-100}},
                color={95,95,95},
                thickness=0.5),
              Text(
                extent={{-90,20},{56,-20}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                textString="Control"),
              Text(
                extent={{-102,140},{100,100}},
                textColor={0,0,0},
                textString="%name")}),   Diagram(coordinateSystem(preserveAspectRatio=
                 false, extent={{-100,-100},{100,100}})));
      end ControlCCA;
    end Controls;

    package Examples
      extends Modelica.Icons.ExamplesPackage;
    end Examples;
  end ConcreteCoreActivation;

  package CeilingInjectionDiffusor

    model CIDSystem_approx

      Fluid.Sources.Boundary_pT                   bound_sup(redeclare package
          Medium = AixLib.Media.Air,
        nPorts=1)       annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-40,50})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
            Media.Air) annotation (Placement(transformation(extent={{-50,90},{
                -30,110}}), iconTransformation(extent={{-50,90},{-30,110}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
            Media.Water) annotation (Placement(transformation(extent={{-50,-110},
                {-30,-90}}), iconTransformation(extent={{-50,-110},{-30,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
            Media.Water) annotation (Placement(transformation(extent={{30,-110},
                {50,-90}}), iconTransformation(extent={{30,-110},{50,-90}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
            Media.Air) annotation (Placement(transformation(extent={{30,90},{50,
                110}}), iconTransformation(extent={{30,90},{50,110}})));
      Fluid.Sources.Boundary_pT                   bound_ret(
        redeclare package Medium = AixLib.Media.Air,
        use_T_in=true,
        nPorts=1)       annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={40,48})));
      Modelica.Blocks.Sources.CombiTimeTable Office_RoomTemp(
        tableOnFile=true,
        tableName="measurement",
        fileName=ModelicaServices.ExternalReferences.loadResource(
            "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Office_Hall_Temp.txt"),
        columns=2:8,
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));

      Modelica.Blocks.Math.Gain T_office(k=1/5)
        annotation (Placement(transformation(extent={{80,20},{60,40}})));
      Modelica.Blocks.Math.MultiSum sum_T_office(nu=5)
        annotation (Placement(transformation(extent={{74,-4},{84,6}})));
      HydraulicModules.SimpleConsumer Hall1(
        redeclare package Medium = AixLib.Media.Water,
        m_flow_nominal=0.15,
        T_start=291.15,
        functionality="Q_flow_input") "Thermal zone"
        annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
      Modelica.Blocks.Sources.TimeTable cid_heatflow_kW(table=[0,3.5; 86400,3.5;
            2678400,9; 5270400,8.5; 7948800,7.9; 10627200,10.45; 13132800,8.3;
            15811200,5; 18403200,0.25; 21081600,1; 23673600,0; 26352000,0.6;
            29030400,7; 31536000,3.5])
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.Blocks.Math.Gain heatflow_Watt(k=-1000) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-6,-8})));
      Fluid.FixedResistances.PressureDrop      res_sup_air(
        redeclare package Medium = AixLib.Media.Air,
        from_dp=true,
        m_flow_nominal=m_flow_nominal_air_office,
        dp_nominal=100)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-40,80})));
      Fluid.FixedResistances.PressureDrop      res_ret_air(
        redeclare package Medium = AixLib.Media.Air,
        m_flow_nominal=m_flow_nominal_air_office,
        dp_nominal=100)      annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={40,80})));
      Fluid.FixedResistances.PressureDrop res_sup_water(
        redeclare package Medium = AixLib.Media.Water,
        m_flow_nominal=m_flow_nominal_water,
        dp_nominal=3e4)  annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-40,-74})));
      Fluid.FixedResistances.PressureDrop res_ret_water(
        redeclare package Medium = AixLib.Media.Water,
        m_flow_nominal=m_flow_nominal_water,
        dp_nominal=10)   annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={40,-74})));
      Fluid.Sensors.TemperatureTwoPort senTem_water_sup(redeclare package
          Medium =
            AixLib.Media.Water, m_flow_nominal=0.15)
        annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
      Fluid.Sensors.TemperatureTwoPort senTem_water_ret(redeclare package
          Medium =
            AixLib.Media.Water, m_flow_nominal=0.15)
        annotation (Placement(transformation(extent={{16,-50},{36,-30}})));
      BaseClasses.Interfaces.CIDBus cIDBus annotation (Placement(transformation(
              extent={{-120,-20},{-80,20}}), iconTransformation(extent={{-120,
                -20},{-80,20}})));
      parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_air_office=0.66
        "Nominal mass flow rate";
      parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_water=0.3
        "Nominal mass flow rate";
    equation
      connect(T_office.y, bound_ret.T_in) annotation (Line(points={{59,30},{44,
              30},{44,36}},               color={0,0,127}));
      connect(sum_T_office.y, T_office.u) annotation (Line(points={{84.85,1},{
              84.85,30},{82,30}},
                               color={0,0,127}));
      connect(Office_RoomTemp.y[1], sum_T_office.u[1]) annotation (Line(points={{61,0},{
              61,-0.4},{74,-0.4}},            color={0,0,127}));
      connect(Office_RoomTemp.y[2], sum_T_office.u[2]) annotation (Line(points={{61,0},{
              61,0.3},{74,0.3}},              color={0,0,127}));
      connect(Office_RoomTemp.y[3], sum_T_office.u[3])
        annotation (Line(points={{61,0},{61,1},{74,1}},       color={0,0,127}));
      connect(Office_RoomTemp.y[4], sum_T_office.u[4]) annotation (Line(points={{61,0},{
              61,1.7},{74,1.7}},              color={0,0,127}));
      connect(Office_RoomTemp.y[5], sum_T_office.u[5]) annotation (Line(points={{61,0},{
              61,2.4},{74,2.4}},              color={0,0,127}));
      connect(port_b2, port_b2)
        annotation (Line(points={{40,-100},{40,-100}}, color={0,127,255}));
      connect(cid_heatflow_kW.y, heatflow_Watt.u) annotation (Line(points={{-39,10},
              {-6,10},{-6,4}},                   color={0,0,127}));
      connect(heatflow_Watt.y, Hall1.Q_flow) annotation (Line(points={{-6,-19},
              {-6,-30}},                                color={0,0,127}));
      connect(port_a1, res_sup_air.port_a)
        annotation (Line(points={{-40,100},{-40,90}}, color={0,127,255}));
      connect(res_sup_air.port_b, bound_sup.ports[1])
        annotation (Line(points={{-40,70},{-40,60}},
                                                   color={0,127,255}));
      connect(bound_ret.ports[1], res_ret_air.port_a)
        annotation (Line(points={{40,58},{40,70}},         color={0,127,255}));
      connect(res_ret_air.port_b, port_b1)
        annotation (Line(points={{40,90},{40,100}}, color={0,127,255}));
      connect(res_sup_water.port_a, port_a2)
        annotation (Line(points={{-40,-84},{-40,-100}}, color={0,127,255}));
      connect(res_ret_water.port_b, port_b2)
        annotation (Line(points={{40,-84},{40,-100}}, color={0,127,255}));
      connect(res_sup_water.port_b, senTem_water_sup.port_a) annotation (Line(
            points={{-40,-64},{-40,-40},{-36,-40}},           color={0,127,255}));
      connect(senTem_water_sup.port_b, Hall1.port_a)
        annotation (Line(points={{-16,-40},{-10,-40}}, color={0,127,255}));
      connect(Hall1.port_b, senTem_water_ret.port_a)
        annotation (Line(points={{10,-40},{16,-40}},color={0,127,255}));
      connect(senTem_water_ret.port_b, res_ret_water.port_a)
        annotation (Line(points={{36,-40},{40,-40},{40,-64}},
                                                     color={0,127,255}));
      connect(senTem_water_sup.T, cIDBus.TWaterSup) annotation (Line(points={{
              -26,-29},{-26,-24},{-99.9,-24},{-99.9,0.1}}, color={0,0,127}),
          Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(senTem_water_ret.T, cIDBus.TWaterRet) annotation (Line(points={{
              26,-29},{26,-24},{-99.9,-24},{-99.9,0.1}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(T_office.y, cIDBus.TAirRet) annotation (Line(points={{59,30},{
              -99.9,30},{-99.9,0.1}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      annotation (Icon(                                             graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),      Text(
              extent={{-100,0},{100,-40}},
              textColor={0,0,0},
              textString="%name
"),         Rectangle(
              extent={{-50,44},{50,24}},
              lineThickness=1,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineColor={0,0,0}),
            Line(
              points={{50,44},{70,64},{-70,64},{-50,44}},
              color={0,0,0},
              thickness=1),
            Rectangle(
              extent={{-34,-98},{-46,20}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{46,-94},{34,20}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-56,68},{-66,84}},
              color={255,255,255},
              thickness=1),
            Line(
              points={{58,70},{68,84}},
              color={255,255,255},
              thickness=1),
            Line(
              points={{66,70},{76,84}},
              color={255,255,255},
              thickness=1),
            Line(
              points={{-64,68},{-74,84}},
              color={255,255,255},
              thickness=1)}));
    end CIDSystem_approx;
  end CeilingInjectionDiffusor;

  package CeilingPanelHeaters
    model CPHSystem

      replaceable package Medium = AixLib.Media.Water constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
      parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.2
        "Nominal mass flow rate" annotation (Dialog(group="CPH"));

      BaseClasses.CPH.RadiantCeilingPanelHeater radiantCeilingPanelHeater(
          genericPipe(length=17.2),
          final m_flow_nominal=m_flow_nominal)
        annotation (Dialog(enable=true, group="CPH"),Placement(transformation(extent={{-20,80},{20,120}})));

      HydraulicModules.Throttle                       cph_Throttle(
        length=1,
        Kv=8,
        final m_flow_nominal=m_flow_nominal,
        redeclare package Medium = Medium,
        pipe1(length=1),
        pipe2(length=30, fac=2),
        pipe3(length=30),
        T_amb=273.15 + 10,
        T_start=343.15) annotation (Dialog(enable=true, group="Hydraulic"),Placement(transformation(
            extent={{-40,-40},{40,40}},
            rotation=90,
            origin={0,20})));

      HydraulicModules.Injection2WayValve                       cph_Valve(
        redeclare package Medium = Medium,
        pipeModel="SimplePipe",
        length=1,
        Kv=12,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
          PumpInterface(pumpParam=
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN25_H1_6_V4()),
        final m_flow_nominal=m_flow_nominal,
        pipe1(length=0.4),
        pipe2(length=0.1),
        pipe3(length=1),
        pipe5(length=0.3),
        pipe4(length=1),
        pipe6(length=0.3),
        T_amb=273.15 + 10,
        T_start=343.15,
        pipe7(length=0.3))
                        annotation (Dialog(enable=true, group="Hydraulic"),Placement(transformation(
            extent={{-40.0007,-40.0003},{39.9998,39.9999}},
            rotation=90,
            origin={-0.000115564,-79.9998})));

      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{
                -34,-150},{-14,-130}}), iconTransformation(extent={{-50,-150},{
                -30,-130}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            AixLib.Media.Water) annotation (Placement(transformation(extent={{
                14,-150},{34,-130}}), iconTransformation(extent={{30,-150},{50,
                -130}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_port_CPH
        annotation (Placement(transformation(extent={{-10,130},{10,150}}),
            iconTransformation(extent={{-10,130},{10,150}})));
      BaseClasses.Interfaces.CPHBus cphBus annotation (Placement(transformation(
              extent={{-100,-20},{-60,22}}), iconTransformation(extent={{-100,
                -20},{-60,22}})));
    equation
      connect(cph_Throttle.port_b2, cph_Valve.port_a2) annotation (Line(points={{24,-20},
              {24,-40},{24.0001,-40}},                         color={0,127,255}));
      connect(radiantCeilingPanelHeater.port_b1,heat_port_CPH)
        annotation (Line(points={{0,120},{0,140}},    color={191,0,0}));
      connect(port_a, cph_Valve.port_a1) annotation (Line(points={{-24,-140},{
              -24,-130},{-24,-120},{-24,-120}}, color={0,127,255}));
      connect(port_b, cph_Valve.port_b2) annotation (Line(points={{24,-140},{24,
              -120},{24.0001,-120}}, color={0,127,255}));
      connect(cph_Throttle.port_a2, radiantCeilingPanelHeater.port_b)
        annotation (Line(points={{24,60},{24,80},{40,80},{40,100},{20,100}},
            color={0,127,255}));
      connect(cph_Throttle.port_b1, radiantCeilingPanelHeater.port_a)
        annotation (Line(points={{-24,60},{-24,80},{-40,80},{-40,100},{-19.3333,
              100}}, color={0,127,255}));
      connect(cph_Valve.port_b1, cph_Throttle.port_a1) annotation (Line(points={{-24,-40},
              {-24,-22},{-24,-20},{-24,-20}},
            color={0,127,255}));
      connect(cph_Throttle.hydraulicBus, cphBus.throttleBus) annotation (Line(
          points={{-40,20},{-79.9,20},{-79.9,1.105}},
          color={255,204,51},
          thickness=0.5));
      connect(cph_Valve.hydraulicBus, cphBus.injectionBus) annotation (Line(
          points={{-40,-80.0002},{-60,-80.0002},{-60,-80},{-79.9,-80},{-79.9,
              1.105}},
          color={255,204,51},
          thickness=0.5));
      annotation (Icon(coordinateSystem(                           extent={{-80,
                -140},{80,140}}), graphics={
            Rectangle(
              extent={{-80,140},{80,-140}},
              lineColor={0,0,0},
              fillColor={212,212,212},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-66,84},{64,52}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-40,50},{-40,30}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{-20,50},{-20,30}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{0,50},{0,30}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{20,50},{20,30}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{40,50},{40,30}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Line(
              points={{60,50},{60,30}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Text(
              extent={{-80,120},{78,80}},
              textColor={0,0,0},
              textString="%name"),
            Line(
              points={{-62,50},{-62,30}},
              color={255,128,0},
              pattern=LinePattern.Dash,
              thickness=1),
            Rectangle(
              extent={{46,-136},{34,18}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-34,-140},{-46,18}},
              lineColor={0,0,0},
              pattern=LinePattern.None,
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid)}),
                              Diagram(coordinateSystem(
              extent={{-80,-140},{80,140}})),
        experiment(StopTime=7200, __Dymola_Algorithm="Dassl"));
    end CPHSystem;

    package Controls "Controller components for the CPH"
      model ControlCPH_ProgrammHall

        /** Control strategie out of TwinCat **/
        BaseClasses.Interfaces.CPHBus distributeBus_CPH annotation (Placement(
              transformation(extent={{80,-20},{120,20}}), iconTransformation(
                extent={{78,-22},{118,20}})));
        Modelica.Blocks.Continuous.LimPID PID_Valve(
          yMin=0,
          Td=0.5,
          yMax=1,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=250,
          k=0.001) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-30,50})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={50,30})));
        Modelica.Blocks.Continuous.LimPID PID_ValveThrottle(
          yMin=0,
          Td=0.5,
          yMax=1,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=250,
          k=0.001) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={70,-30})));
        Modelica.Blocks.Sources.CombiTimeTable Hall2(
          tableOnFile=true,
          tableName="measurement",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Office_Hall_Temp.txt"),
          columns=2:8,
          smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
          annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));

        BaseClasses.Controls.HeatCurve heatCurve(x=-1.481, b=60)
          annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Modelica.Blocks.Interfaces.RealInput T_amb
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
              iconTransformation(extent={{-120,-20},{-80,20}})));
        Modelica.Blocks.Sources.Constant n_const(k=0.6*4250) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={50,70})));
        Modelica.Blocks.Math.MultiSum sumHallTemp(nu=2)
          annotation (Placement(transformation(extent={{-20,-100},{0,-80}})));
        Modelica.Blocks.Math.Gain meanTemp(k=1/2)
          annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
        Modelica.Blocks.Sources.Constant TBasic(k=20.5) annotation (Placement(
              transformation(
              extent={{-7,-7},{7,7}},
              rotation=0,
              origin={-47,-37})));
        Modelica.Blocks.Math.MultiSum calcTSet(nu=2)
          annotation (Placement(transformation(extent={{-14,-44},{-2,-32}})));
        Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
              extent={{7,-7},{-7,7}},
              rotation=180,
              origin={-55,-13})));
        Modelica.Blocks.Sources.Constant b(k=16383.5) annotation (Placement(
              transformation(
              extent={{-7,-7},{7,7}},
              rotation=0,
              origin={-67,13})));
        Modelica.Blocks.Math.Gain a(k=1/(16383.5*5))
          annotation (Placement(transformation(extent={{-38,-20},{-24,-6}})));
        Modelica.Blocks.Sources.CombiTimeTable Hall2_Offset_and_Radiation(
          tableOnFile=true,
          tableName="measurement",
          fileName=ModelicaServices.ExternalReferences.loadResource(
              "modelica://AixLib/Systems/EONERC_Testhall/DataBase/Hall2.txt"),
          columns=2:13,
          smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
          "7 - Offset, 8 - Radiation"
          annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
        Modelica.Blocks.Math.Add addtoKelvin
          annotation (Placement(transformation(extent={{30,-60},{42,-48}})));
        Modelica.Blocks.Sources.Constant CtoK(k=273.15) annotation (Placement(
              transformation(
              extent={{-6,-6},{6,6}},
              rotation=0,
              origin={12,-20})));
      equation
        connect(heatCurve.T_sup, PID_Valve.u_s)
          annotation (Line(points={{-57.9,50.1},{-46,50.1},{-46,50},{-42,50}},
                                                       color={0,0,127}));
        connect(T_amb, heatCurve.T_amb)
          annotation (Line(points={{-120,0},{-90,0},{-90,50},{-82,50}},
                                                      color={0,0,127}));
        connect(sumHallTemp.y, meanTemp.u)
          annotation (Line(points={{1.7,-90},{18,-90}},    color={0,0,127}));
        connect(meanTemp.y, PID_ValveThrottle.u_m) annotation (Line(points={{41,-90},
                {70,-90},{70,-42}},   color={0,0,127}));
        connect(TBasic.y, calcTSet.u[1]) annotation (Line(points={{-39.3,-37},{
                -14,-37},{-14,-39.05}},   color={0,0,127}));
        connect(b.y, feedback.u2) annotation (Line(points={{-59.3,13},{-55,13},
                {-55,-7.4}},
                         color={0,0,127}));
        connect(feedback.y, a.u)
          annotation (Line(points={{-48.7,-13},{-39.4,-13}},
                                                           color={0,0,127}));
        connect(a.y, calcTSet.u[2]) annotation (Line(points={{-23.3,-13},{-20,
                -13},{-20,-36},{-14,-36},{-14,-36.95}},
                                      color={0,0,127}));
        connect(calcTSet.y, addtoKelvin.u2) annotation (Line(points={{-0.98,-38},
                {6,-38},{6,-57.6},{28.8,-57.6}},
                                           color={0,0,127}));
        connect(CtoK.y, addtoKelvin.u1) annotation (Line(points={{18.6,-20},{24,
                -20},{24,-50},{28.8,-50},{28.8,-50.4}},
                              color={0,0,127}));
        connect(addtoKelvin.y, PID_ValveThrottle.u_s)
          annotation (Line(points={{42.6,-54},{52,-54},{52,-30},{58,-30}},
                                                         color={0,0,127}));
        connect(Hall2.y[7], sumHallTemp.u[1]) annotation (Line(points={{-79,-90},
                {-20,-90},{-20,-91.75}},       color={0,0,127}));
        connect(Hall2_Offset_and_Radiation.y[8], sumHallTemp.u[2]) annotation (Line(
              points={{-79,-50},{-20,-50},{-20,-88.25}},          color={0,0,127}));
        connect(Hall2_Offset_and_Radiation.y[7], feedback.u1)
          annotation (Line(points={{-79,-50},{-68,-50},{-68,-13},{-60.6,-13}},
                                                                  color={0,0,127}));
        connect(n_const.y, distributeBus_CPH.throttleBus.pumpBus.rpmSet)
          annotation (Line(points={{61,70},{100.1,70},{100.1,0.1}}, color={0,0,
                127}));
        connect(booleanExpression1.y, distributeBus_CPH.throttleBus.pumpBus.onSet)
          annotation (Line(points={{61,30},{100.1,30},{100.1,0.1}}, color={255,
                0,255}));
        connect(PID_ValveThrottle.y, distributeBus_CPH.throttleBus.valveSet)
          annotation (Line(points={{81,-30},{100.1,-30},{100.1,0.1}}, color={0,
                0,127}));
        connect(PID_Valve.y, distributeBus_CPH.injectionBus.valveSet)
          annotation (Line(points={{-19,50},{0,50},{0,0.1},{100.1,0.1}}, color=
                {0,0,127}));
        connect(PID_Valve.u_m, distributeBus_CPH.injectionBus.TFwrdOutMea)
          annotation (Line(points={{-30,38},{-30,0},{100.1,0},{100.1,0.1}},
              color={0,0,127}));
        connect(booleanExpression1.y, distributeBus_CPH.injectionBus.pumpBus.onSet)
          annotation (Line(points={{61,30},{100.1,30},{100.1,0.1}}, color={255,
                0,255}));
        connect(n_const.y, distributeBus_CPH.injectionBus.pumpBus.rpmSet)
          annotation (Line(points={{61,70},{100.1,70},{100.1,0.1}}, color={0,0,
                127}));
        connect(heatCurve.T_sup, distributeBus_CPH.TSupSet) annotation (Line(
              points={{-57.9,50.1},{-52,50.1},{-52,50},{-48,50},{-48,100},{100,
                100},{100,0.1},{100.1,0.1}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Text(
                extent={{-90,20},{56,-20}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                textString="HCMI"),
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Line(
                points={{20,100},{100,0},{20,-100}},
                color={95,95,95},
                thickness=0.5),
              Text(
                extent={{-90,20},{56,-20}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                textString="Control"),
              Text(
                extent={{-100,140},{100,100}},
                textColor={0,0,0},
                textString="%name")}),   Diagram(coordinateSystem(preserveAspectRatio=
                 false)));
      end ControlCPH_ProgrammHall;

      model ControlCPH

        BaseClasses.Interfaces.CPHBus                      distributeBus_CPH
          annotation (Placement(transformation(extent={{80,-20},{120,20}}),
              iconTransformation(extent={{78,-22},{118,20}})));
        Modelica.Blocks.Continuous.LimPID PID_Valve(
          yMin=0,
          Td=0.5,
          yMax=1,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=Ti,
          k=k)     annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-10,60})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={50,-30})));

        Modelica.Blocks.Sources.Constant n_const(k=0.6*4250) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={50,30})));
        Modelica.Blocks.Sources.Constant ThrottSet(k=0.665) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={10,-70})));
        Subsystems.BaseClasses.Controls.HeatCurve heatCurve(x=x, b=b)
          annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
        Modelica.Blocks.Interfaces.RealInput T_amb
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
              iconTransformation(extent={{-140,-20},{-100,20}})));
        parameter Real k=0.01 "Gain of controller";
        parameter Modelica.Units.SI.Time Ti=250
          "Time constant of Integrator block";
        parameter Real x=-1.481 "slope" annotation (Dialog(group="Heat Curve"));
        parameter Real b=60 "offset" annotation (Dialog(group="Heat Curve"));
      equation
        connect(heatCurve.T_sup, PID_Valve.u_s)
          annotation (Line(points={{-37.9,60.1},{-34,60.1},{-34,60},{-22,60}},
                                                       color={0,0,127}));
        connect(T_amb,heatCurve. T_amb)
          annotation (Line(points={{-120,0},{-80,0},{-80,60},{-62,60}},
                                                      color={0,0,127}));
        connect(n_const.y, distributeBus_CPH.injectionBus.pumpBus.rpmSet)
          annotation (Line(points={{61,30},{100.1,30},{100.1,0.1}}, color={0,0,
                127}));
        connect(booleanExpression1.y, distributeBus_CPH.injectionBus.pumpBus.onSet)
          annotation (Line(points={{61,-30},{100.1,-30},{100.1,0.1}}, color={
                255,0,255}));
        connect(ThrottSet.y, distributeBus_CPH.throttleBus.valveSet)
          annotation (Line(points={{21,-70},{100.1,-70},{100.1,0.1}}, color={0,
                0,127}));
        connect(PID_Valve.y, distributeBus_CPH.injectionBus.valveSet)
          annotation (Line(points={{1,60},{100.1,60},{100.1,0.1}}, color={0,0,
                127}));
        connect(PID_Valve.u_m, distributeBus_CPH.throttleBus.TFwrdOutMea)
          annotation (Line(points={{-10,48},{-10,0.1},{100.1,0.1}}, color={0,0,
                127}));
        connect(heatCurve.T_sup, distributeBus_CPH.TSupSet) annotation (Line(
              points={{-37.9,60.1},{-30,60.1},{-30,80},{100.1,80},{100.1,0.1}},
              color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Text(
                extent={{-90,20},{56,-20}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                textString="HCMI"),
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Line(
                points={{20,100},{100,0},{20,-100}},
                color={95,95,95},
                thickness=0.5),
              Text(
                extent={{-90,20},{56,-20}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                textString="Control"),
              Text(
                extent={{-100,140},{100,100}},
                textColor={0,0,0},
                textString="%name")}),   Diagram(coordinateSystem(preserveAspectRatio=
                 false)));
      end ControlCPH;
    end Controls;

    package Examples "Example of the CPH"
      extends Modelica.Icons.ExamplesPackage;
    end Examples;
  end CeilingPanelHeaters;

  package DistrictHeatingStation
    model DHS_substation "District heating substation"

      HydraulicModules.Throttle                       dhs(
        redeclare package Medium = AixLib.Media.Water,
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_42x1(),
        Kv=2.5,
        m_flow_nominal=2.3,
        pipe1(length=14),
        pipe2(length=1),
        pipe3(length=6),
        T_amb=273.15 + 10,
        T_start=323.15) "distribute heating system"
        annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));

      AixLib.Fluid.Sources.Boundary_ph                FernwaermeAus(
        redeclare package Medium = AixLib.Media.Water,
        p=750000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-142,-40},{-122,-20}})));

      AixLib.Fluid.Sources.Boundary_pT                FernwaermeEin(
        redeclare package Medium = AixLib.Media.Water,
        p=1150000,
        T=373.15,
        nPorts=1) "nominal mass flow 1 kg/s"
        annotation (Placement(transformation(extent={{-140,20},{-120,40}})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe1(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_76_1x1_5(),
        length=4.5,
        redeclare package Medium = AixLib.Media.Water,
        m_flow_nominal=m_flow_nominal,
        T_start=353.15)     annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={90,30})));

      AixLib.Fluid.HeatExchangers.ConstantEffectiveness     hex(
        redeclare package Medium1 = AixLib.Media.Water,
        redeclare package Medium2 = AixLib.Media.Water,
        m1_flow_nominal=2.3,
        m2_flow_nominal=2,
        dp1_nominal=10,
        dp2_nominal=10,
        eps=0.95) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=90)));

      HydraulicModules.Pump                       pump(
        redeclare package Medium = AixLib.Media.Water,
        pipeModel="SimplePipe",
        length=1,
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_64x2(),
        m_flow_nominal=m_flow_nominal,
        redeclare
          AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpHeadControlled
          PumpInterface(pumpParam=
              AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN30_H1_12()),
        pipe1(length=3.5),
        pipe2(length=7),
        pipe3(length=10),
        T_amb=273.15 + 10,
        T_start=353.15)
        annotation (Placement(transformation(extent={{20,-20},{60,20}})));
      AixLib.Fluid.FixedResistances.GenericPipe pipe14(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_76_1x1_5(),
        length=1.5,
        redeclare package Medium = AixLib.Media.Water,
        m_flow_nominal=m_flow_nominal,
        T_start=353.15)     annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={90,-30})));

      AixLib.Fluid.FixedResistances.GenericPipe pipe15(
        parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_42x1(),
        length=12,
        redeclare package Medium = AixLib.Media.Water,
        m_flow_nominal=2.3) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-90,-12})));

      AixLib.Fluid.MixingVolumes.MixingVolume     vol1(
        redeclare package Medium = AixLib.Media.Water,
        m_flow_nominal=3,
        V=0.1,
        p_start=120000,
        T_start=353.15,
        nPorts=2)       annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={140,-50})));

      AixLib.Fluid.Sources.Boundary_pT ret_c1(
        redeclare package Medium = AixLib.Media.Water,
        p=100000,
        use_T_in=false,
        nPorts=1) annotation (Placement(transformation(extent={{8,-8},{-8,8}},
            rotation=270,
            origin={110,-70})));
      BaseClasses.Interfaces.DHSBus dhsBus annotation (Placement(transformation(
              extent={{-20,80},{20,120}}), iconTransformation(extent={{-20,80},
                {20,120}})));
      Fluid.Sensors.Pressure senPressure_sup(redeclare package Medium =
            AixLib.Media.Water)
        annotation (Placement(transformation(extent={{60,40},{80,60}})));
      Fluid.Sensors.Pressure senPressure_ret(redeclare package Medium =
            AixLib.Media.Water)
        annotation (Placement(transformation(extent={{60,-40},{80,-60}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            AixLib.Media.Water)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{150,20},{170,40}}),
            iconTransformation(extent={{148,60},{168,80}})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            AixLib.Media.Water)
        "Fluid connector b (positive design flow direction is from port_a to port_b)"
        annotation (Placement(transformation(extent={{150,-40},{170,-20}}),
            iconTransformation(extent={{148,-80},{168,-60}})));
      parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=2
        "Nominal mass flow rate";
    equation
      connect(FernwaermeEin.ports[1], dhs.port_a1)
        annotation (Line(points={{-120,30},{-108,30},{-108,12},{-60,12}},
                                                     color={0,127,255}));
      connect(dhs.port_b1, hex.port_a1) annotation (Line(points={{-20,12},{-6,
              12},{-6,10}},               color={0,127,255}));
      connect(hex.port_b1, dhs.port_a2)
        annotation (Line(points={{-6,-10},{-6,-12},{-20,-12}},
                                                           color={0,127,255}));

      connect(hex.port_b2, pump.port_a1)
        annotation (Line(points={{6,10},{6,12},{20,12}},      color={0,127,255}));
      connect(hex.port_a2, pump.port_b2)
        annotation (Line(points={{6,-10},{6,-12},{20,-12}}, color={0,127,255}));

      connect(FernwaermeAus.ports[1], pipe15.port_a) annotation (Line(points={{-122,
              -30},{-110,-30},{-110,-12},{-100,-12}},       color={0,127,255}));
      connect(pipe15.port_b, dhs.port_b2) annotation (Line(points={{-80,-12},{
              -60,-12}},                           color={0,127,255}));

      connect(ret_c1.ports[1], pipe14.port_a) annotation (Line(points={{110,-62},
              {110,-30},{100,-30}},      color={0,127,255}));
      connect(pump.port_b1, pipe1.port_a) annotation (Line(points={{60,12},{70,
              12},{70,30},{80,30}},        color={0,127,255}));
      connect(senPressure_sup.port, pump.port_b1) annotation (Line(points={{70,40},
              {70,12},{60,12}},            color={0,127,255}));
      connect(pipe14.port_b, pump.port_a2) annotation (Line(points={{80,-30},{
              70,-30},{70,-12},{60,-12}},color={0,127,255}));
      connect(senPressure_ret.port, pump.port_a2) annotation (Line(points={{70,-40},
              {70,-12},{60,-12}},                 color={0,127,255}));
      connect(pipe1.port_b, port_b)
        annotation (Line(points={{100,30},{160,30}}, color={0,127,255}));
      connect(port_a, vol1.ports[1]) annotation (Line(points={{160,-30},{141,
              -30},{141,-40}}, color={0,127,255}));
      connect(pipe14.port_a, vol1.ports[2]) annotation (Line(points={{100,-30},
              {139,-30},{139,-40}}, color={0,127,255}));
      connect(dhs.hydraulicBus, dhsBus.throttleBus) annotation (Line(
          points={{-40,20},{-40,100.1},{0.1,100.1}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(pump.hydraulicBus, dhsBus.pumpBus) annotation (Line(
          points={{40,20},{40,100},{0.1,100},{0.1,100.1}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(senPressure_ret.p, dhsBus.pressureReturn) annotation (Line(points
            ={{81,-50},{120,-50},{120,100.1},{0.1,100.1}}, color={0,0,127}));
      connect(senPressure_sup.p, dhsBus.pressureSupply) annotation (Line(points
            ={{81,50},{100,50},{100,100.1},{0.1,100.1}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(                           extent={{-160,
                -100},{160,100}}),
                              graphics={
            Rectangle(
              extent={{-160,100},{160,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{-122,20},{-42,-20}},
              lineColor={0,0,0},
              fillColor={135,135,135},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-10,60},{-160,80}},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{10,-75},{-10,75}},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid,
              origin={85,70},
              rotation=-90),
            Rectangle(
              extent={{-10,-60},{-28,60}},
              pattern=LinePattern.None,
              fillColor={255,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{10,-76},{-10,76}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={84,-70},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{10,-75},{-10,75}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={-85,-70},
              rotation=-90,
              lineColor={0,0,0}),
            Rectangle(
              extent={{4,80},{10,-80}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-83,20},{-43,0},{-83,-20}},
              color={95,95,95},
              thickness=0.5),
            Rectangle(
              extent={{-10,80},{-4,-80}},
              lineColor={0,0,0},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-60,-8},{60,8}},
              pattern=LinePattern.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              origin={18,0},
              rotation=-90,
              lineColor={0,0,0})}),             Diagram(coordinateSystem(
                                         extent={{-160,-100},{160,100}})),
        experiment(StopTime=10000, __Dymola_Algorithm="Dassl"));
    end DHS_substation;

    package Controls "Control components for DHS"
      model ControlDHS
        BaseClasses.Interfaces.DHSBus distributeBus_DHS annotation (Placement(
              transformation(extent={{80,-20},{120,20}}), iconTransformation(
                extent={{78,-22},{118,20}})));
        Modelica.Blocks.Continuous.LimPID PID_Valve(
          yMin=0,
          Td=0.5,
          yMax=1,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=Ti_valve,
          k=k_valve)
                   annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={0,70})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=true)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-90,0})));
        Modelica.Blocks.Sources.Constant dp_set_Pa(k=0.25e5)
          "probaby between 0.1e5 and 0.25e5" annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-30,-50})));
        parameter Real k_valve=0.002 "Gain of controller";
        parameter Modelica.Units.SI.Time Ti_valve=3000
          "Time constant of Integrator block";
        parameter Real k_pump=0.2 "Gain of controller";
        parameter Modelica.Units.SI.Time Ti_pump=3000
          "Time constant of Integrator block";
        Modelica.Blocks.Math.Gain Pa_to_mWS(k=1/10000)
          annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
      equation
        connect(PID_Valve.y, distributeBus_DHS.throttleBus.valveSet)
          annotation (Line(points={{11,70},{100.1,70},{100.1,0.1}}, color={0,0,
                127}));
        connect(PID_Valve.u_s, distributeBus_DHS.setpoint) annotation (Line(
              points={{-12,70},{-30,70},{-30,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(dp_set_Pa.y, Pa_to_mWS.u)
          annotation (Line(points={{-19,-50},{18,-50}}, color={0,0,127}));
        connect(Pa_to_mWS.y, distributeBus_DHS.pumpBus.pumpBus.dpSet)
          annotation (Line(points={{41,-50},{100.1,-50},{100.1,0.1}}, color={0,
                0,127}));
        connect(PID_Valve.u_m, distributeBus_DHS.pumpBus.TFwrdOutMea)
          annotation (Line(points={{0,58},{0,0.1},{100.1,0.1}}, color={0,0,127}));
        connect(booleanExpression1.y, distributeBus_DHS.pumpBus.pumpBus.onSet)
          annotation (Line(points={{-79,0},{10,0},{10,0.1},{100.1,0.1}}, color=
                {255,0,255}));
        annotation (Icon(graphics={
              Text(
                extent={{-90,20},{56,-20}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                textString="HCMI"),
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Line(
                points={{20,100},{100,0},{20,-100}},
                color={95,95,95},
                thickness=0.5),
              Text(
                extent={{-90,20},{56,-20}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                textString="Control"),
              Text(
                extent={{-100,140},{100,100}},
                textColor={0,0,0},
                textString="%name")}),   experiment(
            StopTime=400000,
            __Dymola_NumberOfIntervals=200,
            __Dymola_Algorithm="Dassl"));
      end ControlDHS;
    end Controls;

    package Examples
      extends Modelica.Icons.ExamplesPackage;
    end Examples;
  end DistrictHeatingStation;

  package JetNozzle
    model JN
      Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
            AixLib.Media.Air) annotation (Placement(transformation(extent={{
                -110,-30},{-90,-10}}), iconTransformation(extent={{-110,-60},{
                -90,-40}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
            AixLib.Media.Air) annotation (Placement(transformation(extent={{
                -110,30},{-90,50}}), iconTransformation(extent={{-110,40},{-90,
                60}})));

      Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
            AixLib.Media.Air) annotation (Placement(transformation(extent={{90,
                30},{110,50}}), iconTransformation(extent={{90,40},{110,60}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
            AixLib.Media.Air) annotation (Placement(transformation(extent={{90,
                -30},{110,-10}}), iconTransformation(extent={{90,-60},{110,-40}})));
      Fluid.Actuators.Dampers.Exponential        AirValve(
        redeclare package Medium = AixLib.Media.Air,
        each m_flow_nominal=m_flow_nominal,
        dpDamper_nominal=2,
        dpFixed_nominal=2,
        each l=0.01) "if Valve Kv=100 " annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={0,-20})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
            AixLib.Media.Air, m_flow_nominal=2.64)
        annotation (Placement(transformation(extent={{60,30},{40,50}})));
      BaseClasses.Interfaces.JNBus jNBus annotation (Placement(transformation(
              extent={{-20,80},{20,120}}), iconTransformation(extent={{-20,80},
                {20,120}})));
      parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=2.64
        "Nominal mass flow rate";
    equation
      connect(port_a1, AirValve.port_a)
        annotation (Line(points={{-100,-20},{-10,-20}}, color={0,127,255}));
      connect(AirValve.port_b, port_b1)
        annotation (Line(points={{10,-20},{100,-20}}, color={0,127,255}));
      connect(port_a2, senTem.port_a)
        annotation (Line(points={{100,40},{60,40}}, color={0,127,255}));
      connect(senTem.port_b, port_b2)
        annotation (Line(points={{40,40},{-100,40}}, color={0,127,255}));
      connect(senTem.T, jNBus.retTemp) annotation (Line(points={{50,51},{50,
              100.1},{0.1,100.1}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(AirValve.y, jNBus.valveSet) annotation (Line(points={{0,-8},{0,
              100.1},{0.1,100.1}}, color={0,0,127}), Text(
          string="%second",
          index=1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid), Text(
              extent={{-100,-100},{100,-140}},
              textColor={0,0,0},
              textString="%name
"),         Ellipse(
              extent={{-38,-20},{-50,-82}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Ellipse(
              extent={{-62,-10},{-76,-94}},
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              lineThickness=1),
            Rectangle(
              extent={{-58,-98},{-70,0}},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None,
              lineColor={0,0,0}),
            Line(points={{-44,-82},{-70,-92}}, pattern=LinePattern.None),
            Line(
              points={{-70,-10},{-44,-20}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-70,-94},{-44,-82}},
              color={0,0,0},
              thickness=1),
            Line(points={{-100,-52}}, color={28,108,200}),                                                                                                              Polygon(points={{-58,-62},
                  {-2,-44},{44,-50},{38,-64},{92,-90},{54,-36},{46,-44},{-20,-38},{-58,
                  -62}},                                                                                                                                                                                                       lineColor = {0, 0, 0}, smooth = Smooth.Bezier, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid),
            Line(
              points={{-64,-2},{64,-2},{58,2}},
              color={0,0,0},
              origin={0,76},
              rotation=180),
            Line(points={{-58,82},{-64,78}},   color={0,0,0}),
            Line(
              points={{64,-2},{-64,-2},{-58,2}},
              color={0,0,0},
              origin={0,-96},
              rotation=180),
            Line(points={{58,-90},{64,-94}},   color={0,0,0}),
            Ellipse(
              extent={{-60,66},{-44,34}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-52,66},{-100,66}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-52,34},{-100,34}},
              color={0,0,0},
              thickness=1),                                                                                                                                             Polygon(points={{34,58},
                  {-12,54},{-10,40},{-54,50},{-22,70},{-14,62},{74,60},{90,48},{34,58}},                                                                                                                                       lineColor = {0, 0, 0}, smooth = Smooth.Bezier, fillColor = {255, 255, 255},
                fillPattern =                                                                                                   FillPattern.Solid),
            Line(
              points={{-70,-94},{-100,-94}},
              color={0,0,0},
              thickness=1),
            Line(
              points={{-70,-10},{-100,-10}},
              color={0,0,0},
              thickness=1)}),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=10000000, __Dymola_Algorithm="Dassl"));
    end JN;

    package Controls
      model ControlJN
        BaseClasses.Interfaces.JNBus jnBus annotation (Placement(transformation(
                extent={{80,-20},{120,20}}), iconTransformation(extent={{78,-22},
                  {118,20}})));
        Modelica.Blocks.Continuous.LimPID PID_AirValve(
          yMin=0,
          Td=0.5,
          yMax=1,
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          Ti=Ti_valve,
          k=k_valve)
                   annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0)));
        Modelica.Blocks.Sources.Constant RoomTemp_set(k=setpoint)    annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-50,0})));
        parameter Real k_valve=0.01 "Gain of controller"
          annotation (Dialog(group="PI Control"));
        parameter Modelica.Units.SI.Time Ti_valve=1000
          "Time constant of Integrator block"
          annotation (Dialog(group="PI Control"));
        parameter Real setpoint=20 + 273.15
          "Setpoint for testhall air temperature"
          annotation (Dialog(group="PI Control"));
      equation
        connect(RoomTemp_set.y, PID_AirValve.u_s)
          annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
        connect(PID_AirValve.y, jnBus.valveSet) annotation (Line(points={{11,0},
                {100.1,0},{100.1,0.1}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(PID_AirValve.u_m, jnBus.retTemp) annotation (Line(points={{0,
                -12},{0,-20},{100.1,-20},{100.1,0.1}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Text(
                extent={{-90,20},{56,-20}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                textString="HCMI"),
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid),
              Line(
                points={{20,100},{100,0},{20,-100}},
                color={95,95,95},
                thickness=0.5),
              Text(
                extent={{-90,20},{56,-20}},
                lineColor={95,95,95},
                lineThickness=0.5,
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                textString="Control"),
              Text(
                extent={{-100,140},{100,100}},
                textColor={0,0,0},
                textString="%name")}),   Diagram(coordinateSystem(
                preserveAspectRatio=false)));
      end ControlJN;
    end Controls;

    package Examples
      extends Modelica.Icons.ExamplesPackage;
    end Examples;
  end JetNozzle;

  package BaseClasses
    package CPH
      model RadiantCeilingPanelHeater

        parameter Integer nNodes=3
                                 "Number of elements";
        parameter Real Gr(unit="m2")=27
          "Net radiation conductance between two surfaces (see docu)";

        AixLib.Fluid.FixedResistances.GenericPipe
                                         genericPipe(
          length=17,
          final m_flow_nominal=m_flow_nominal,
          nNodes=nNodes,
          redeclare package Medium = AixLib.Media.Water,
          T_start=343.15)
          annotation (Dialog(enable=true), Placement(transformation(extent={{-12,-60},
                  {12,-36}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
              AixLib.Media.Water)
          "Fluid connector b (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{50,-10},{70,10}}),
              iconTransformation(extent={{50,-10},{70,10}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
              AixLib.Media.Water)
          "Fluid connector a (positive design flow direction is from port_a to port_b)"
          annotation (Placement(transformation(extent={{-70,-10},{-50,10}}),
              iconTransformation(extent={{-68,-10},{-48,10}})));
        Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation[nNodes](each Gr=Gr)
                                  annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=
              nNodes) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={0,30})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b1
          annotation (Placement(transformation(extent={{-10,50},{10,70}}),
              iconTransformation(extent={{-10,50},{10,70}})));
        parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=m_flow_nominal
          "Nominal mass flow rate";
      equation
        connect(genericPipe.port_b, port_b) annotation (Line(points={{12,-48},{
                40,-48},{40,0},{60,0}}, color={0,127,255}));
        connect(genericPipe.port_a, port_a) annotation (Line(points={{-12,-48},
                {-40,-48},{-40,0},{-60,0}}, color={0,127,255}));
        connect(thermalCollector.port_a, bodyRadiation.port_b)
          annotation (Line(points={{0,20},{0,10}}, color={191,0,0}));
        connect(thermalCollector.port_b, port_b1)
          annotation (Line(points={{0,40},{0,60}}, color={191,0,0}));
        connect(genericPipe.heatPort, bodyRadiation[nNodes].port_a)
          annotation (Line(points={{0,-36},{0,-10}},
                                                   color={191,0,0}));
        annotation (Icon(coordinateSystem(extent={{-60,-60},{60,60}}),graphics={
              Rectangle(
                extent={{-60,60},{60,-60}},
                fillPattern=FillPattern.Solid,
                fillColor={215,215,215},
                pattern=LinePattern.None),
              Rectangle(
                extent={{-52,38},{52,18}},
                lineColor={0,0,0},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-44,14},{-44,-6}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{-32,14},{-32,-6}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{-20,14},{-20,-6}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{-8,14},{-8,-6}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{4,14},{4,-6}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{16,14},{16,-6}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{26,14},{26,-6}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{36,14},{36,-6}},
                color={255,128,0},
                pattern=LinePattern.Dash),
              Line(
                points={{46,14},{46,-6}},
                color={255,128,0},
                pattern=LinePattern.Dash)}),                           Diagram(
              coordinateSystem(extent={{-60,-60},{60,60}})));
      end RadiantCeilingPanelHeater;
    end CPH;

    package CCA
      model ConcreteCoreActivation
      import      Modelica.Units.SI;
        parameter SI.Area area "Area of activated concrete"
          annotation (Dialog(group="Concrete core activation"));
        parameter SI.Length thickness "Thickness of activated concrete"
          annotation (Dialog(group="Concrete core activation"));
        parameter SI.SpecificHeatCapacity cp=1000
          "Specific heat capacity of concrete"
          annotation (Dialog(group="Concrete core activation"));
        parameter SI.Density rho=2300 "Density of activated concrete"
          annotation (Dialog(group="Concrete core activation"));
        parameter SI.CoefficientOfHeatTransfer alpha=10 "Heat transfer coefficient concrete to air"
          annotation (Dialog(group="Concrete core activation"));

        AixLib.Fluid.FixedResistances.GenericPipe pipe(
          redeclare package Medium = AixLib.Media.Water,
          length=100,
          withInsulation=false,
          withConvection=false,
          m_flow_nominal=m_flow_nominal,
          T_start=T_start_hydraulic)                               "Pipe that goes through the concrete" annotation (Dialog(enable=true,group="Pipe"),
            Placement(transformation(
              extent={{10,10},{-10,-10}},
              rotation=180)));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=rho*
              area*thickness*cp, T(start=T_start, displayUnit="K"))
                                       annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={30,40})));
        Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,70})));
        Modelica.Blocks.Sources.Constant const(k=area*alpha)
          annotation (Placement(transformation(extent={{-60,34},{-40,54}})));

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort
          "heat port for connection to room volume" annotation (Placement(
              transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},
                  {10,110}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
              AixLib.Media.Water)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
              AixLib.Media.Water)
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=heatCapacitor.T)
          annotation (Placement(transformation(extent={{40,60},{60,80}})));
        Modelica.Blocks.Interfaces.RealOutput TConcrete "Value of Real output"
          annotation (Placement(transformation(extent={{100,60},{120,80}}),
              iconTransformation(extent={{100,62},{120,82}})));
        parameter SI.MassFlowRate m_flow_nominal=1 "Nominal mass flow rate";
        parameter SI.Temperature T_start_hydraulic=Medium.T_default
          "Initialization temperature at pipe inlet"
          annotation (Dialog(tab="Initialization"));
        parameter SI.Temperature T_start=293.15
          "Initialization temperature of capacity"
          annotation (Dialog(tab="Initialization"));
      equation
        connect(heatCapacitor.port,convection. solid)
          annotation (Line(points={{20,40},{0,40},{0,60},{-6.66134e-16,60}},
                                                               color={191,0,0}));
        connect(convection.fluid,heatPort)
          annotation (Line(points={{4.44089e-16,80},{4.44089e-16,82},{0,82},{0,
                100}},                                       color={191,0,0}));
        connect(convection.Gc,const. y)
          annotation (Line(points={{-10,70},{-22,70},{-22,44},{-39,44}},
                                                      color={0,0,127}));
        connect(port_a, pipe.port_a) annotation (Line(points={{-100,0},{-55,0},{-55,1.72085e-15},
                {-10,1.72085e-15}}, color={0,127,255}));
        connect(pipe.port_b, port_b) annotation (Line(points={{10,-7.21645e-16},{55,-7.21645e-16},
                {55,0},{100,0}}, color={0,127,255}));
        connect(realExpression.y, TConcrete)
          annotation (Line(points={{61,70},{110,70}}, color={0,0,127}));
        connect(pipe.heatPort, heatCapacitor.port)
          annotation (Line(points={{0,10},{0,40},{20,40}}, color={191,0,0}));
       annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillColor={212,212,212},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{4,79},{-16,75},{-36,69},{-48,55},{-54,47},{-64,37},{-68,
                    25},{-72,11},{-74,-3},{-72,-19},{-72,-31},{-72,-41},{-66,-53},
                    {-60,-61},{-44,-65},{-26,-71},{-14,-71},{2,-73},{12,-77},{26,
                    -77},{36,-75},{46,-69},{58,-63},{60,-61},{70,-49},{72,-41},{
                    74,-39},{76,-23},{80,-9},{82,-1},{82,15},{78,27},{70,37},{58,
                    45},{48,53},{40,69},{30,77},{4,79}},
                lineColor={255,0,0},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-56,45},{-66,35},{-70,23},{-74,9},{-76,-5},{-74,-21},{-74,-33},
                    {-74,-43},{-68,-55},{-62,-63},{-46,-67},{-28,-73},{-16,-73},{0,-75},
                    {10,-79},{24,-79},{34,-77},{44,-71},{56,-65},{44,-67},{42,-67},{32,
                    -69},{22,-71},{20,-71},{12,-71},{4,-67},{-10,-63},{-20,-63},{-28,-61},
                    {-38,-55},{-48,-45},{-54,-33},{-56,-25},{-56,-15},{-58,-3},{-58,5},
                    {-58,17},{-56,27},{-54,29},{-50,37},{-46,45},{-42,55},{-38,67},{-56,
                    45}},
                lineColor={255,0,0},
                fillColor={160,160,164},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-65,19},{75,-12}},
                lineColor={0,0,0},
                textString="%name"),
              Line(points={{146,-70}}, color={255,0,0})}),             Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end ConcreteCoreActivation;
    end CCA;

    package Interfaces
      expandable connector HallHydraulicBus "Distribute Data Bus"
        extends Modelica.Icons.SignalBus;
        import      Modelica.Units.SI;

        AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_cca;
        AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_cph;
        AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_cph_throttle;
        AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_cid;
        AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_jn;
        AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_dhs;
        AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus bus_dhs_pump;

        annotation (Diagram(coordinateSystem(initialScale=0.2)), Icon(
              coordinateSystem(initialScale=0.2)));
      end HallHydraulicBus;

      expandable connector JNBus
        "Control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;
        import      Modelica.Units.SI;
        SI.Temperature retTemp "Return temperature"
          annotation (HideResult=false);
        SI.Temperature setpoint "Setpoint for air temperature of testhall"
          annotation (HideResult=false);
        Real valveSet(min=0, max=1) "Valve opening setpoint 0..1";
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                        extent={{-20,2},{22,-2}},
                        lineColor={255,204,51},
                        lineThickness=0.5)}), Documentation(info="<html>
<p>
This connector defines the \"expandable connector\" ControlBus that
is used as bus in the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
Note, this connector contains \"default\" signals that might be utilized
in a connection (the input/output causalities of the signals
are determined from the connections to this bus).
</p>
</html>"));

      end JNBus;

      expandable connector MainBus "Main Bus"
        extends Modelica.Icons.SignalBus;
        import      Modelica.Units.SI;

        AixLib.Systems.EONERC_Testhall.Subsystems.BaseClasses.Interfaces.CCABus bus_cca;
        AixLib.Systems.EONERC_Testhall.Subsystems.BaseClasses.Interfaces.CPHBus bus_cph;
        AixLib.Systems.EONERC_Testhall.Subsystems.BaseClasses.Interfaces.CIDBus bus_cid;
        AixLib.Systems.EONERC_Testhall.Subsystems.BaseClasses.Interfaces.JNBus bus_jn;
        AixLib.Systems.EONERC_Testhall.Subsystems.BaseClasses.Interfaces.DHSBus bus_dhs;
        AixLib.Systems.EONERC_Testhall.Subsystems.BaseClasses.Interfaces.ZoneBus bus_zone;
        AixLib.Systems.ModularAHU.BaseClasses.GenericAHUBus bus_ahu;
        annotation (Diagram(coordinateSystem(initialScale=0.2)), Icon(
              coordinateSystem(initialScale=0.2)));
      end MainBus;

      expandable connector CIDBus
        "Control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;
        import      Modelica.Units.SI;
        SI.Temperature TWaterSup "Supply temperature water"
          annotation (HideResult=false);
        SI.Temperature TWaterRet "Return temperature water"
          annotation (HideResult=false);
        SI.Temperature TAirRet "Supply temperature air"
          annotation (HideResult=false);
       annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                        extent={{-20,2},{22,-2}},
                        lineColor={255,204,51},
                        lineThickness=0.5)}), Documentation(info="<html>
<p>
This connector defines the \"expandable connector\" ControlBus that
is used as bus in the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
Note, this connector contains \"default\" signals that might be utilized
in a connection (the input/output causalities of the signals
are determined from the connections to this bus).
</p>
</html>"));

      end CIDBus;

      expandable connector CCABus
        "Control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;
        import      Modelica.Units.SI;
        AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus;
        SI.Temperature coreTemp "Return temperature"
          annotation (HideResult=false);
        SI.Temperature TSupSet "Supply temperature setpoint"
          annotation (HideResult=false);
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                        extent={{-20,2},{22,-2}},
                        lineColor={255,204,51},
                        lineThickness=0.5)}), Documentation(info="<html>
<p>
This connector defines the \"expandable connector\" ControlBus that
is used as bus in the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
Note, this connector contains \"default\" signals that might be utilized
in a connection (the input/output causalities of the signals
are determined from the connections to this bus).
</p>
</html>"));

      end CCABus;

      expandable connector CPHBus
        "Control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;
        import      Modelica.Units.SI;
        AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus throttleBus;
        AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus injectionBus;
        SI.Temperature TSupSet "Supply temperature setpoint"
          annotation (HideResult=false);
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                        extent={{-20,2},{22,-2}},
                        lineColor={255,204,51},
                        lineThickness=0.5)}), Documentation(info="<html>
<p>
This connector defines the \"expandable connector\" ControlBus that
is used as bus in the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
Note, this connector contains \"default\" signals that might be utilized
in a connection (the input/output causalities of the signals
are determined from the connections to this bus).
</p>
</html>"));

      end CPHBus;

      expandable connector DHSBus
        "Control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;
        import      Modelica.Units.SI;
        AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus throttleBus;
        AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus pumpBus;
        Real pressureSupply(final quantity="AbsolutePressure", final unit="Pa", min=0)
                                                                                      "Supply pressure"
        annotation (HideResult=false);
        Real pressureReturn( final quantity="AbsolutePressure", final unit="Pa", min=0) "Return pressure"
          annotation (HideResult=false);
        Real setpoint "Supply temperature setpoint"
          annotation (HideResult=false);
        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                        extent={{-20,2},{22,-2}},
                        lineColor={255,204,51},
                        lineThickness=0.5)}), Documentation(info="<html>
<p>
This connector defines the \"expandable connector\" ControlBus that
is used as bus in the
<a href=\"modelica://Modelica.Blocks.Examples.BusUsage\">BusUsage</a> example.
Note, this connector contains \"default\" signals that might be utilized
in a connection (the input/output causalities of the signals
are determined from the connections to this bus).
</p>
</html>"));

      end DHSBus;

      expandable connector ZoneBus
        "Control bus that is adapted to the signals connected to it"
        extends Modelica.Icons.SignalBus;
        import      Modelica.Units.SI;
        SI.Temperature zoneTemp "Zone temperature"
          annotation (HideResult=false);
      end ZoneBus;
    end Interfaces;

    package Controls
      model HeatCurve

        parameter Real u_lower = 15 "heating limit" annotation(Dialog(tab = "General", group = "Limits"));
        parameter Real t_sup_upper = 80 "upper supply temperature limit" annotation(Dialog(tab = "General", group = "Limits"));
        parameter Real x = -1 "slope" annotation(Dialog(tab = "General", group = "Heat Curve"));
        parameter Real b = 10 "offset" annotation(Dialog(tab = "General", group = "Heat Curve"));

        Real t_ambient;
        Real y;

        Modelica.Blocks.Interfaces.RealInput T_amb(unit="K")
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
              iconTransformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput T_sup(unit="K")
          annotation (Placement(transformation(extent={{100,-20},{140,20}}),
              iconTransformation(extent={{-19,-19},{19,19}},
              rotation=0,
              origin={121,1})));
        Modelica.Blocks.Sources.Constant KelvinConstant(k=273.15) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-30,50})));
        Modelica.Blocks.Math.Add t_sup
          annotation (Placement(transformation(extent={{40,-10},{60,10}})));
        Modelica.Blocks.Sources.RealExpression t_supply(y=y)
          annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
        Modelica.Blocks.Math.Add t_amb(k1=-1)
          annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      equation

        t_ambient = min(t_amb.y, u_lower);

        y = min(((x * t_ambient) + b), t_sup_upper);

        connect(t_supply.y, t_sup.u2) annotation (Line(points={{1,-30},{20,-30},{20,-6},
                {38,-6}},           color={0,0,127}));
        connect(t_sup.u1, KelvinConstant.y) annotation (Line(points={{38,6},{20,6},{20,
                50},{-19,50}},                         color={0,0,127}));
        connect(t_sup.y, T_sup)
          annotation (Line(points={{61,0},{120,0}},   color={0,0,127}));
        connect(t_amb.u2, T_amb) annotation (Line(points={{-62,-6},{-80,-6},{-80,0},{-120,
                0}},          color={0,0,127}));
        connect(t_amb.u1, KelvinConstant.y) annotation (Line(points={{-62,6},{-80,6},{
                -80,20},{0,20},{0,50},{-19,50}},             color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{102,-100}},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,0}),
              Line(
                points={{-48,-48}},
                color={0,0,0},
                pattern=LinePattern.None),
              Line(
                points={{-130,-60}},
                color={0,0,0},
                pattern=LinePattern.None),
              Line(
                points={{-94,-80},{86,-80}},
                color={215,215,215},
                thickness=1,
                arrow={Arrow.None,Arrow.Filled}),
              Line(
                points={{-80,-94},{-80,86}},
                color={215,215,215},
                thickness=1,
                arrow={Arrow.None,Arrow.Filled}),
              Line(
                points={{-80,58},{38,-66}},
                color={238,46,47},
                thickness=1),
              Line(
                points={{38,-66},{70,-66}},
                color={238,46,47},
                thickness=1),
              Line(
                points={{-98,58},{-80,58}},
                color={238,46,47},
                thickness=1),
              Polygon(
                points={{-80,96},{-88,74},{-72,74},{-80,96}},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                pattern=LinePattern.None),
              Polygon(
                points={{0,11},{-8,-11},{8,-11},{0,11}},
                fillColor={215,215,215},
                fillPattern=FillPattern.Solid,
                origin={84,-79},
                rotation=270,
                pattern=LinePattern.None)}),                           Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Input: T_amb in Kelvin</p>
<p>Output: T_Supply in Kelvin</p>
<p>Setting of Heat Curve Characteristic:</p>
<ul>
<li>u: Ambient temperature above which only the minimum supply temperature is required in &deg;C</li>
<li>t_supply_upper: Maximum supply temperature in &deg;C</li>
</ul>
</html>"));
      end HeatCurve;
    end Controls;
  end BaseClasses;
end Subsystems;
