% Author: Julio Zaragoza
% The University of Adelaide, Adelaide, South Australia
    
% Example: using the CACC function for discretizing continuos data.
%
% Note that such data appeared in the paper: 
%  'A Discretization Algorithm based on Class-Attribute Contingency Coefficient' (CACC), 
%  by Sheng-Jung Tsai, Shien-I Lee and Wei-Pang Yang, Information Sciences, Elsevier, 2008
%  and my results are the same as those reported in the paper.


[ discdata,discvalues,discscheme ] = cacc(contdata)