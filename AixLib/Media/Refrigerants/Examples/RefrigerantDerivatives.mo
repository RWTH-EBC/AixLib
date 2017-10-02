within AixLib.Media.Refrigerants.Examples;
model RefrigerantDerivatives
  "Model that checks the implementation of derivatives"
  extends Modelica.Icons.Example;

  // Define the refrigerant that shall be tested
  package Medium =
      AixLib.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
    "Internal medium model";

  parameter Medium.AbsolutePressure p = 1e5;
  constant Real convT(unit="K/s3") = 270
  "Conversion factor to satisfy unit check";

  Medium.Temperature T;
  Medium.SpecificEnthalpy h_Sym "Liquid phase enthalpy";
  Medium.SpecificEnthalpy h_Calc "Liquid phase enthalpy";

initial equation
  h_Sym = h_Calc;

equation
  T = 273.15 + convT*time^3;
  h_Calc = Medium.specificEnthalpy_pT(p=p,T=T);
  der(h_Sym) = der(h_Calc);

end RefrigerantDerivatives;
