within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Controler;
model ControlerHumidifier "controler for humidifier"
  parameter Boolean use_PhiSet = false
    "true if relative humidity is controlled, otherwise absolute humidity is controlled";
  Modelica.Blocks.Interfaces.RealInput Xset if not use_PhiSet
    "set value for absolute humidity at cooler outlet"
    annotation (Placement(transformation(extent={{-140,-30},{-100,10}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Interfaces.RealInput PhiSet if use_PhiSet
    "set value for relative humidity at ahu outlet"
    annotation (Placement(transformation(extent={{-140,-90},{-100,-50}}),
        iconTransformation(extent={{-120,-70},{-100,-50}})));
  Utilities.Psychrometrics.X_pTphi x_pTphi(use_p_in=false) if use_PhiSet
    annotation (Placement(visible=(use_PhiSet==true),transformation(extent={{-60,-44},{-40,-24}})));
  Modelica.Blocks.Interfaces.RealInput Tset if use_PhiSet
    "set value for temperature at cooler outlet"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}}),
        iconTransformation(extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Interfaces.RealOutput XHumSet
    "set value for humidity control of humidifier"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Modelica.Blocks.Interfaces.RealInput X_intern "internal mass fraction";
equation

  if use_PhiSet then
    connect(x_pTphi.X[1],X_intern);
    connect(Tset, x_pTphi.T) annotation (Line(visible=(use_PhiSet==true),points={{-120,50},{-74,50},{-74,-34},
          {-62,-34}}, color={0,0,127}));
    connect(PhiSet, x_pTphi.phi) annotation (Line(visible=(use_PhiSet==true),points={{-120,-70},{-74,-70},{-74,
          -40},{-62,-40}}, color={0,0,127}));
  else
    connect(Xset, X_intern);
  end if;

  connect(X_intern, XHumSet);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ControlerHumidifier;
