within AixLib.Fluid.BoilerCHP.BaseClasses;
model Polynom
  Modelica.Blocks.Interfaces.RealOutput efficiency
                                      annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{-10,-10},{10,
            10}},
        rotation=0,
        origin={110,0})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput tCold
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));

parameter Real a[:]={0.9,0.9,0.9,0.9,0.9,0.9}
                            "Coefficients for efficiency curve";

protected
    parameter Real CRU_800[6] = {1.957,-0.1781,0.004692,-0.003252,0.0005385,-1.446e-05};

    parameter Real CIB[6] = {1.883,-0.1745,-0.07744,-0.003037,0.0005141,0.0002434};

    parameter Real KBXdash0400[6] = {1.823,-0.1577, 0.07198,-0.002805,0.0004586,-0.0002185};

    parameter Real FTX400[6] = {1.829,-0.09961,0.0332,-0.002809,0.0002765,-9.703e-05};

    parameter Real FBdash2501[6] = {1.719,0.1621,-0.2445,-0.002469,-0.0005191,0.0007235};

equation

efficiency = a[1] + a[2]*u + a[3]*u^2 + (a[4] + a[5]*u + a[6]*u^2)*tCold;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Polynom;
