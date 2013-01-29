//=========================================================================
//  
//  GlobalProcessing FLIM Analysis Package
//  (c) 2013 Sean Warren
//
//
//
//=========================================================================

#ifndef _IRFCONV_H
#define _IRFCONV_H

#include "FLIMGlobalFitController.h"

#define N_EXP_BUF_ROWS 5

void calc_exps(FLIMGlobalFitController *gc, int n_t, double t[], int total_n_exp, double tau[], int n_theta, double theta[], float exp_buf[]);

void conv_irf_tcspc(FLIMGlobalFitController *gc, double rate, double exp_irf_buf[], double exp_irf_cum_buf[], int k, int i, double pulse_fact, double& c);
void conv_irf_timegate(FLIMGlobalFitController *gc, double rate, double exp_irf_buf[], double exp_irf_cum_buf[], int k, int i, double pulse_fact, double& c);

void conv_irf_deriv_tcspc(FLIMGlobalFitController *gc, double t, double rate, double exp_irf_buf[], double exp_irf_cum_buf[], double exp_irf_tirf_buf[], double exp_irf_tirf_cum_buf[], int k, int i, double pulse_fact, double ref_fact, double& c);
void conv_irf_deriv_timegate(FLIMGlobalFitController *gc, double t, double rate, double exp_irf_buf[], double exp_irf_cum_buf[], double exp_irf_tirf_buf[], double exp_irf_tirf_cum_buf[], int k, int i, double pulse_fact, double ref_fact, double& c);

void conv_irf_deriv_ref_tcspc(FLIMGlobalFitController *gc, double t, double rate, double exp_irf_buf[], double exp_irf_cum_buf[], double exp_irf_tirf_buf[], double exp_irf_tirf_cum_buf[], int k, int i, double pulse_fact, double ref_fact, double& c);
void conv_irf_deriv_ref_timegate(FLIMGlobalFitController *gc, double t, double rate, double exp_irf_buf[], double exp_irf_cum_buf[], double exp_irf_tirf_buf[], double exp_irf_tirf_cum_buf[], int k, int i, double pulse_fact, double ref_fact, double& c);

void conv_irf_ref(FLIMGlobalFitController *gc, int n_t, double t[], double exp_buf[], int total_n_exp, double tau[], double beta[], int dim, double a[], int add_components = 0, int inc_beta_fact = 0);
void conv_irf_diff_ref(FLIMGlobalFitController *gc, int n_t, double t[], double exp_buf[], int n_tau, double tau[], double beta[], int dim, double b[], int inc_tau = 1);


//void alf2beta(int n, const double* alf, double beta[]);
//double beta_derv(int n_beta, int alf_idx, int beta_idx, const double alf[]);



template <typename T>
void alf2beta(int n, const T* alf, double beta[])
{
   // For example if there are four components
   // beta[0] =                              alf[0] 
   // beta[1] =                 alf[1]  * (1-alf[0])
   // beta[2] =    alf[2]  * (1-alf[1]) * (1-alf[0])
   // beta[3] = (1-alf[2]) * (1-alf[1]) * (1-alf[0])

   for(int i=0; i<n; i++)
      beta[i] = 1;

   for(int i=0; i<n-1; i++)
   {
      beta[i] *= alf[i];
      for(int j=i+1; j<n; j++)
         beta[j] *= 1-alf[i];
   }

}

template <typename T>
T alf2beta(int n, const T* alf, int j)
{
   T beta = 1;
   for(int i=0; i<(j-1); i++)
      beta *= (1-alf[i]);
   
   if ( j == (n-1) )
      beta *= (1-alf[j-1]);
   else
      beta *= alf[j];

   return beta;
}

template <typename T>
double beta_derv(int n_beta, int alf_idx, int beta_idx, const T alf[])
{
   double d;

   if(beta_idx<=alf_idx)
      d = 1;
   else if (beta_idx<n_beta-1)
      d = -alf[beta_idx];
   else
      d = -1;

   for(int k=0; k<(beta_idx-1); k++)
   {
      d *= (1-alf[k]);
   }

   return d;
}




inline double anscombe(double x)
{
   return 2 * sqrt(x + 0.375);
}

inline double inv_anscombe(double x)
{
   return x*x*0.25 - 0.375;
}

inline double anscombe_diff(double x)
{
   return 1 / sqrt(x + 0.375);
}



#endif