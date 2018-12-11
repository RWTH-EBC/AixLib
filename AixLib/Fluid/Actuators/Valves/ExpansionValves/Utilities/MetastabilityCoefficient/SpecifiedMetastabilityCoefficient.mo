within AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.MetastabilityCoefficient;
package SpecifiedMetastabilityCoefficient
  model Poly_R407C_16_18_pth
    "Polynomial - Metastabilitycoefficient - R407C - EEV - 1.6 mm"
    extends MetastabilityCoefficient.PolynomialMetastabilityCoefficient(
      final MetaPolyMod=Types.MetaPolynomialModel.Liang2009,
      final a={-0.00846,0.7150,-0.02048,0.000598,0.08231},
      final b={1,1,1,1,1});
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Poly_R407C_16_18_pth;

  model Buck_R22R407CR410A_EEV_16_18_meta
    "Buckingham - Metastabilitycoefficient - Similitude for R22, R407C, R410A - EEV - 1.6 mm to 1.8 mm"
    extends MetastabilityCoefficient.PowerMetastabilityCoefficient(
      final MetaPowMod=Types.MetaPowerModels.Liang2009,
      final a=9.6681,
      final b={0.4314,-0.0844,-0.4871,0.0559,0.2580});

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Buck_R22R407CR410A_EEV_16_18_meta;

  model Poly_C_meta "Calculation of metastability degree"
    extends MetastabilityCoefficient.PolynomialMetastabilityCoefficient(
      final MetaPolyMod=Types.MetaPolynomialModel.Liu2007,
      final a={0.53351,0.015159,0.32296,-0.14936},
      final b={1,1,1,1});
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Poly_C_meta;

  model Poly_R410A_16_18_pth
    "Polynomial - Metastabilitycoefficient - R410 - EEV - 1.6 mm"
    extends MetastabilityCoefficient.PolynomialMetastabilityCoefficient(
      final MetaPolyMod=Types.MetaPolynomialModel.Liang2009,
      final a={-0.24002,0.6609,0.06320,-0.01959,0.09674},
      final b={1,1,1,1,1});

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Poly_R410A_16_18_pth;

  model Poly_R22_16_18_pth
    "Polynomial - Metastabilitycoefficient - R22 - EEV - 1.6 mm"
    extends MetastabilityCoefficient.PolynomialMetastabilityCoefficient(
      final MetaPolyMod=Types.MetaPolynomialModel.Liang2009,
      final a={-0.1229,0.7308,-0.01127,9.9668e-5,0.1162},
      final b={1,1,1,1,1});
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Poly_R22_16_18_pth;

  model ConstantMetastabilityCoefficient
    "Constant condition for metastability degree"
      extends BaseClasses.Coefficient.PartialMetastabilityCoefficient;

    //Definition of parameters
    parameter Real C_meta_const(
      unit="1",
      min=0,
      max=1,
      nominal=0.25) = 0.4;

  equation
    C_meta = C_meta_const
    "Metastabilitatcoefficient";

    p_th = pOut;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-58,-4},{56,-88}},
            lineColor={28,108,200},
            textString="M
"),   Ellipse(extent={{-110,118},{80,-88}}, lineColor={28,108,200})}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ConstantMetastabilityCoefficient;
  annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Ellipse(
          origin={10.0,10.0},
          fillColor={76,76,76},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{-80.0,-80.0},{-20.0,-20.0}}),
        Ellipse(
          origin={10.0,10.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{0.0,-80.0},{60.0,-20.0}}),
        Ellipse(
          origin={10.0,10.0},
          fillColor={128,128,128},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          extent={{0.0,0.0},{60.0,60.0}}),
        Ellipse(
          origin={10.0,10.0},
          lineColor={128,128,128},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-80.0,0.0},{-20.0,60.0}})}));
end SpecifiedMetastabilityCoefficient;
