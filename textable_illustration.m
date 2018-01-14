%% This script illustrates the use of the textable function
clc;clear;close all;

% Johannes Fleck; https://github.com/Jo-Fleck
% Please leave the above URL in the code if you choose to redistribute it.
% Thank you. Feedback and suggestions welcome.

% Fun will now commence

%% See the function for details on required and optional inputs

% Table with all inputs
a = [1 2 3; 4 5 6; 7 8 10];
b = 'table_all';
c = '/Users/main/Documents/GitHubRepos/textable';
d = 'tablename';
e = 'table';
f = {1990, 2000, 2010};
g = {'Alabama', 'New Jersey', 'Virginia'};
textable(a, b, c, d, e, f, g)

% Table with only required inputs
aa = a;
bb = 'table_req';
textable(aa, bb)



