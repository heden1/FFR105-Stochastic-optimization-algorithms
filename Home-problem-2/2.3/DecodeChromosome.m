% nIn = the number of inputs
% nHidden = the number of hidden neurons
% nOut = the number of output neurons
% Weights (and biases) should take values in the range [-wMax,wMax]

function [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);

    vectorWIH=chromosome(1:nHidden*(nIn+1))*wMax*2-wMax;
    vectorWHO=chromosome(nHidden*(nIn+1)+1:end)*wMax*2-wMax;

    wIH=(reshape(vectorWIH,[],[nHidden])');
    wHO=(reshape(vectorWHO,[],[nOut])');
% Decoding: Starting from a chromosome of length nHidden x (nIn+1) + nOut x (nHidden+1), use
%           The first nHidden x (nIn+1)  genes to obtain wIH, and the remaining genes
%           to obtain wHO. The weights and the biases (i.e. the elements of the matrices) 
%           should take values in the range [-wMax,wMax], so the alleles (values of the
%           genes in the chromosome) must be rescaled correctly.
%

% The maximum (absolute) value of weights and biases. Thus, they take values in
% the range [-wMax,wMax]


% Sample network of size 3-3-2. Note the the number of rows in wIH MUST be
% equal to the number of columns in wHO, minus 1; see also the definition of nH below.
%
% Note: Your encoding and decoding methods should work for any values of nIn, nHidden, and nOut,
% not just for the example below! Thus, test your encoding and decoding functions by
% defining different set of matrices wIH and wHO (fulfilling the criterion on nH, see below)
%

% Note: Each component of x should take values in [-a,a], where a = wMax.

