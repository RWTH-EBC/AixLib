within AixLib.DataBase.Media.Refrigerants;
record HelmholtzEquationOfStateBaseDateDefinition
  "Base data definition for fitting coefficients of the Helmholtz EoS"
  extends Modelica.Icons.Record;

  parameter String name
  "Short description of the record"
  annotation (Dialog(group="General"));

  parameter Integer alpha_0_nL
  "Number of terms of the equation's (alpha_0) first part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Real alpha_0_l1[:]
  "First coefficient of the equation's (alpha_0) first part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Real alpha_0_l2[:]
  "Second coefficient of the equation's (alpha_0) first part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Integer alpha_0_nP
  "Number of terms of the equation's (alpha_0) second part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Real alpha_0_p1[:]
  "First coefficient of the equation's (alpha_0) second part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Real alpha_0_p2[:]
  "Second coefficient of the equation's (alpha_0) second part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Integer alpha_0_nE
  "Number of terms of the equation's (alpha_0) third part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Real alpha_0_e1[:]
  "First coefficient of the equation's (alpha_0) third part"
  annotation (Dialog(group="Ideal gas part"));
  parameter Real alpha_0_e2[:]
  "Second coefficient of the equation's (alpha_0) third part"
  annotation (Dialog(group="Ideal gas part"));

  parameter Integer alpha_r_nP
  "Number of terms of the equation's (alpha_r) first part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_p1[:]
  "First coefficient of the equation's (alpha_r) first part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_p2[:]
  "Second coefficient of the equation's (alpha_r) first part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_p3[:]
  "Third coefficient of the equation's (alpha_r) first part"
  annotation (Dialog(group="Residual part"));
  parameter Integer alpha_r_nB
  "Number of terms of the equation's (alpha_r) second part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_b1[:]
  "First coefficient of the equation's (alpha_r) second part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_b2[:]
  "Second coefficient of the equation's (alpha_r) second part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_b3[:]
  "Third coefficient of the equation's (alpha_r) second part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_b4[:]
  "Fourth coefficient of the equation's (alpha_r) second part"
  annotation (Dialog(group="Residual part"));
  parameter Integer alpha_r_nG
  "Number of terms of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_g1[:]
  "First coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_g2[:]
  "Second coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_g3[:]
  "Third coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_g4[:]
  "Fourth coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_g5[:]
  "Fifth coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_g6[:]
  "Sixth coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));
  parameter Real alpha_r_g7[:]
  "Seventh coefficient of the equation's (alpha_r) third part"
  annotation (Dialog(group="Residual part"));

end HelmholtzEquationOfStateBaseDateDefinition;
