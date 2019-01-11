within AixLib.DataBase.Media.Refrigerants.R32;
record EoS_IIR_P1_57_T233_373 "Record with Coefficients for EoS"
  extends
    AixLib.DataBase.Media.Refrigerants.HelmholtzEquationOfStateBaseDateDefinition(
    name="Coefficients taken from Tillner-Roth, Yokozeki 'An International Standard Equation of State for Difluoromethane R-32  for
           Temperatures from the Triple Point at 136.34 K to 435 K and Pressures up to 70 MPa'",
    f_IdgNl = 1,
    f_IdgL1 = {3.004486},
    f_IdgL2 =  {1},
    f_IdgNp= 2,
    f_IdgP1 = {-8.258096, 6.353098},
    f_IdgP2 = {0,1},
    f_IdgNe = 4,
    f_IdgE1 = {1.160761, 2.645151, 5.794987, 1.129475},
    f_IdgE2 = {2.2718538, 11.9144210, 5.1415638, 32.7682170},
    f_ResNp = 8,
    f_ResP1 = {0.1046634e1, -0.5451165, -0.2448595e-2, -0.4877002e-1, 0.3520158e-1, 0.1622750e-2, 0.2377225e-4, 0.29149e-1},
    f_ResP2 = {1, 2, 5, 1, 1, 3, 8, 4},
    f_ResP3 = {0.25, 1, -0.25, -1, 2, 2, 0.75, 0.25},
    f_ResNb = 11,
    f_ResB1 = {0.3386203e-2, -0.4202444e-2, 0.4782025e-3, -0.5504323e-2, -0.2418396e-1, 0.4209034, -0.4616537, -0.1200513e1, -0.2591550e1, -0.1400145e1, 0.8263017},
    f_ResB2 = {4, 4, 8, 3, 5, 1, 1, 3, 1, 2, 3},
    f_ResB3 = {18, 26, -1, 25, 1.75, 4, 5, 1, 1.5, 1, 0.5},
    f_ResB4 = {4, 3, 1, 4, 1, 2, 2, 1, 1, 1, 1},
    f_ResNG = 0,
    f_ResNNa = 0);


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end EoS_IIR_P1_57_T233_373;
