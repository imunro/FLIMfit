#ifndef _VARIABLEPROJECTOR_H
#define _VARIABLEPROJECTOR_H

#include "AbstractFitter.h"
#include "VariableProjection.h"


class VariableProjector : public AbstractFitter
{

public:
   VariableProjector(FitModel* model, int smax, int l, int nl, int nmax, int ndim, int p, double *t, int variable_phi, int* terminate);
   ~VariableProjector();

   int Fit(int s, int n, float* y, float *w, int* irf_idx, double *alf, double *lin_params, double *chi2, int thread, int itmax, double chi2_factor, int& niter, int &ierr, double& c2);

   int GetFit(int irf_idx, double* alf, double* lin_params, float* adjust, double* fit);

private:

   void Cleanup();

   int varproj(int nsls1, int nls, const double *alf, double *rnorm, double *fjrow, int iflag);   
   void jacb_row(int s, double *kap, double* r__, int d_idx, double* res, double* derv);
   
   void get_linear_params(int idx);
   int bacsub(int idx);

   double d_sign(double *a, double *b);

   // Buffers used by levmar algorithm
   double *fjac;
   double *diag;
   double *qtf;
   double *wa1, *wa2, *wa3, *wa4;
   int    *ipvt;
/*
   // Used by variable projection
   int     inc[96];
   int     ncon;
   int     nconp1;
   int     philp1;

   double *a;
   double *b;
   double *u;
   double *kap;

   int     n;
   int     s;
   int     l;
   int     nl;
   int     p;

   int     smax;
   int     nmax;
   int     ndim;

   int     lp1;

   float  *y;
   float  *w;
   double *lin_params;
   double *chi2;
   double *t;
   int    *irf_idx;
   int thread;
   double chi2_factor;
   double* cur_chi2;
   */
   friend int VariableProjectorCallback(void *p, int m, int n, const double *x, double *fnorm, double *fjrow, int iflag);
};


#endif