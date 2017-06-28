within AixLib.Fluid.Examples.DistrictHeating.Controller;
model ModeBasedController "Mode-Based Controller for the buffer storage"
  Modelica.Blocks.Interfaces.RealInput Stg1TopTemp annotation (Placement(
        transformation(extent={{-203,-6},{-163,34}}), iconTransformation(
          extent={{-191,6},{-163,34}})));
  Modelica.Blocks.Interfaces.RealInput Stg2TopTemp annotation (Placement(
        transformation(extent={{-202,68},{-162,108}}), iconTransformation(
          extent={{-190,80},{-162,108}})));
  Modelica.Blocks.Interfaces.RealInput setPointStg2
    "Setpoint temperature at the top of the storage 2" annotation (Placement(
        transformation(extent={{-202,40},{-162,80}}), iconTransformation(
          extent={{-190,52},{-162,80}})));
  Modelica.Blocks.Logical.OnOffController
                               less(             pre_y_start=true, bandwidth=
        5)
    annotation (Placement(transformation(extent={{-94,38},{-74,58}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(
    pre_y_start=false,
    uLow=5,
    uHigh=10)
    annotation (Placement(transformation(extent={{-94,-2},{-74,18}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{-122,-2},{-102,18}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{-54,16},{-34,36}})));
  Modelica.Blocks.Logical.Switch ValveOpDirSupp
    annotation (Placement(transformation(extent={{56,50},{76,70}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-54,58},{-34,78}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-12,22},{8,42}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{-2,-52},{18,-32}})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-6})));
  Modelica.Blocks.Logical.Switch ValveOpIndirSupp
    annotation (Placement(transformation(extent={{54,-53},{76,-31}})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{4,-16},{24,4}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
    annotation (Placement(transformation(extent={{-4,-84},{16,-64}})));
  Modelica.Blocks.Interfaces.RealOutput ValveOpDir
    annotation (Placement(transformation(extent={{190,44},{220,74}})));
  Modelica.Blocks.Interfaces.RealOutput ValveOpIndir
    annotation (Placement(transformation(extent={{192,-38},{222,-8}})));
  Modelica.Blocks.Logical.Switch MFDir
    annotation (Placement(transformation(extent={{126,2},{146,22}})));
  Modelica.Blocks.Sources.Constant const4(k=4)
    annotation (Placement(transformation(extent={{84,24},{104,44}})));
  Modelica.Blocks.Sources.Constant const5(k=0)
    annotation (Placement(transformation(extent={{84,-16},{104,4}})));
  Modelica.Blocks.Logical.Switch MFIndir
    annotation (Placement(transformation(extent={{148,-78},{168,-58}})));
  Modelica.Blocks.Sources.Constant const6(k=10)
    annotation (Placement(transformation(extent={{98,-58},{118,-38}})));
  Modelica.Blocks.Sources.Constant const7(k=0)
    annotation (Placement(transformation(extent={{90,-94},{110,-74}})));
  Modelica.Blocks.Interfaces.RealOutput MFDirSupp
    annotation (Placement(transformation(extent={{190,14},{220,44}})));
  Modelica.Blocks.Interfaces.RealOutput evaMF
    annotation (Placement(transformation(extent={{192,-68},{222,-38}})));
  Modelica.Blocks.Interfaces.BooleanOutput IndirSuppSignal annotation (
      Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={68,-198})));
  Modelica.Blocks.Interfaces.BooleanOutput DirSuppSignal annotation (
      Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={46,-198}), iconTransformation(
        extent={{-14,-14},{14,14}},
        rotation=270,
        origin={34,-198})));
  Modelica.Blocks.Continuous.LimPID setPointSelection(controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=80,
    yMin=50,
    Ti=10,
    k=0.005)
    annotation (Placement(transformation(extent={{-112,-142},{-90,-120}})));
  Modelica.Blocks.Logical.Switch RPM "Rotational speed of the compressor"
    annotation (Placement(transformation(extent={{-6,-142},{14,-122}})));
  Modelica.Blocks.Sources.Constant const8(k=0)
    annotation (Placement(transformation(extent={{-42,-172},{-22,-152}})));
  Modelica.Blocks.Interfaces.RealOutput CompRPM
    annotation (Placement(transformation(extent={{188,-194},{220,-162}})));
  Modelica.Blocks.Interfaces.RealInput HPCondTemp annotation (Placement(
        transformation(extent={{-206,-192},{-166,-152}}), iconTransformation(
          extent={{-194,-180},{-166,-152}})));
  Modelica.Blocks.Logical.Switch MFIndir1
    annotation (Placement(transformation(extent={{150,-136},{170,-116}})));
  Modelica.Blocks.Sources.Constant const9(k=10)
    annotation (Placement(transformation(extent={{110,-118},{130,-98}})));
  Modelica.Blocks.Sources.Constant const10(k=0)
    annotation (Placement(transformation(extent={{108,-162},{128,-142}})));
  Modelica.Blocks.Interfaces.RealOutput conMF
    annotation (Placement(transformation(extent={{194,-140},{224,-110}})));
  AixLib.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=3700,
    yMin=800,
    Ti=1,
    k=1)  annotation (Placement(transformation(extent={{-62,-141},{-42,-121}})));
equation
  connect(Stg1TopTemp, add.u1)
    annotation (Line(points={{-183,14},{-124,14}}, color={0,0,127}));
  connect(add.y, hysteresis.u)
    annotation (Line(points={{-101,8},{-96,8}}, color={0,0,127}));
  connect(less.y, and1.u1) annotation (Line(points={{-73,48},{-70,48},{-70,26},
          {-56,26}}, color={255,0,255}));
  connect(hysteresis.y, and1.u2) annotation (Line(points={{-73,8},{-70,8},{
          -70,18},{-56,18}}, color={255,0,255}));
  connect(and1.y, ValveOpDirSupp.u2) annotation (Line(points={{-33,26},{-20,
          26},{-20,60},{54,60}}, color={255,0,255}));
  connect(const.y, ValveOpDirSupp.u1)
    annotation (Line(points={{-33,68},{54,68}}, color={0,0,127}));
  connect(const1.y, ValveOpDirSupp.u3) annotation (Line(points={{9,32},{12,32},
          {12,52},{54,52}}, color={0,0,127}));
  connect(and2.u2, and1.u1) annotation (Line(points={{-4,-50},{-64,-50},{-64,
          26},{-56,26}}, color={255,0,255}));
  connect(and1.y, not1.u)
    annotation (Line(points={{-33,26},{-20,26},{-20,6}}, color={255,0,255}));
  connect(not1.y, and2.u1) annotation (Line(points={{-20,-17},{-20,-42},{-4,
          -42}}, color={255,0,255}));
  connect(and2.y, ValveOpIndirSupp.u2)
    annotation (Line(points={{19,-42},{51.8,-42}}, color={255,0,255}));
  connect(const2.y, ValveOpIndirSupp.u1) annotation (Line(points={{25,-6},{42,
          -6},{42,-33.2},{51.8,-33.2}}, color={0,0,127}));
  connect(const3.y, ValveOpIndirSupp.u3) annotation (Line(points={{17,-74},{
          44,-74},{44,-50.8},{51.8,-50.8}}, color={0,0,127}));
  connect(ValveOpDirSupp.y, ValveOpDir)
    annotation (Line(points={{77,60},{205,60},{205,59}}, color={0,0,127}));
  connect(MFDir.u2, ValveOpDirSupp.u2) annotation (Line(points={{124,12},{36,
          12},{36,60},{54,60}}, color={255,0,255}));
  connect(const4.y, MFDir.u1) annotation (Line(points={{105,34},{112,34},{112,
          20},{124,20}}, color={0,0,127}));
  connect(const5.y, MFDir.u3) annotation (Line(points={{105,-6},{114,-6},{114,
          4},{124,4}}, color={0,0,127}));
  connect(MFIndir.u2, ValveOpIndirSupp.u2) annotation (Line(points={{146,-68},
          {34,-68},{34,-42},{51.8,-42}}, color={255,0,255}));
  connect(ValveOpIndirSupp.y, ValveOpIndir) annotation (Line(points={{77.1,
          -42},{82,-42},{86,-42},{86,-23},{207,-23}}, color={0,0,127}));
  connect(const6.y, MFIndir.u1) annotation (Line(points={{119,-48},{124,-48},
          {124,-60},{146,-60}}, color={0,0,127}));
  connect(const7.y, MFIndir.u3) annotation (Line(points={{111,-84},{126,-84},
          {126,-76},{146,-76}}, color={0,0,127}));
  connect(MFDir.y, MFDirSupp) annotation (Line(points={{147,12},{158,12},{158,
          29},{205,29}}, color={0,0,127}));
  connect(MFIndir.y, evaMF) annotation (Line(points={{169,-68},{180,-68},{180,
          -53},{207,-53}}, color={0,0,127}));
  connect(IndirSuppSignal, ValveOpIndirSupp.u2) annotation (Line(points={{68,
          -198},{68,-68},{34,-68},{34,-42},{51.8,-42}}, color={255,0,255}));
  connect(DirSuppSignal, ValveOpDirSupp.u2) annotation (Line(points={{46,-198},
          {46,12},{36,12},{36,60},{54,60}}, color={255,0,255}));
  connect(Stg2TopTemp, setPointSelection.u_m) annotation (Line(points={{-182,
          88},{-132,88},{-132,-162},{-101,-162},{-101,-144.2}}, color={0,0,
          127}));
  connect(RPM.u2, ValveOpIndirSupp.u2) annotation (Line(points={{-8,-132},{
          -16,-132},{-16,-104},{68,-104},{68,-68},{34,-68},{34,-42},{51.8,-42}},
        color={255,0,255}));
  connect(const8.y, RPM.u3) annotation (Line(points={{-21,-162},{-14,-162},{
          -14,-140},{-8,-140}},color={0,0,127}));
  connect(RPM.y, CompRPM) annotation (Line(points={{15,-132},{32,-132},{32,
          -178},{204,-178}}, color={0,0,127}));
  connect(MFIndir1.u2, ValveOpIndirSupp.u2) annotation (Line(points={{148,
          -126},{68,-126},{68,-68},{34,-68},{34,-42},{51.8,-42}}, color={255,
          0,255}));
  connect(const9.y, MFIndir1.u1) annotation (Line(points={{131,-108},{138,
          -108},{138,-118},{148,-118}}, color={0,0,127}));
  connect(const10.y, MFIndir1.u3) annotation (Line(points={{129,-152},{136,
          -152},{136,-134},{148,-134}}, color={0,0,127}));
  connect(MFIndir1.y, conMF) annotation (Line(points={{171,-126},{209,-126},{
          209,-125}}, color={0,0,127}));
  connect(Stg2TopTemp, less.u) annotation (Line(points={{-182,88},{-128,88},{
          -128,42},{-96,42}}, color={0,0,127}));
  connect(setPointStg2, less.reference) annotation (Line(points={{-182,60},{
          -112,60},{-112,54},{-96,54}}, color={0,0,127}));
  connect(setPointStg2, setPointSelection.u_s) annotation (Line(points={{-182,
          60},{-140,60},{-140,-131},{-114.2,-131}}, color={0,0,127}));
  connect(Stg2TopTemp, add.u2) annotation (Line(points={{-182,88},{-152,88},{
          -152,2},{-124,2}}, color={0,0,127}));
  connect(setPointSelection.y, conPID.u_s) annotation (Line(points={{-88.9,
          -131},{-78,-131},{-64,-131}}, color={0,0,127}));
  connect(HPCondTemp, conPID.u_m) annotation (Line(points={{-186,-172},{-52,
          -172},{-52,-143}}, color={0,0,127}));
  connect(conPID.y, RPM.u1) annotation (Line(points={{-41,-131},{-26,-131},{
          -26,-124},{-8,-124}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
            -200},{200,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-200},{200,
            100}}), graphics={Rectangle(
          extent={{-180,-100},{26,-200}},
          lineColor={28,108,200},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-64,-188},{36,-194}},
          lineColor={28,108,200},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="Cascade controller to control the 
temperature at condensor outlet"),
        Text(
          extent={{-118,96},{-66,78}},
          lineColor={238,46,47},
          textString="Stg1 = Seasonal storage
Stg2 = Buffer storage 
",        horizontalAlignment=TextAlignment.Left)}));
end ModeBasedController;
