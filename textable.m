function textable(mat,title,out_dir,caption,label,col_labels,row_labels)

% Johannes Fleck; https://github.com/Jo-Fleck
% Please leave the above URL in the code if you choose to redistribute it.
% Thank you. Feedback and suggestions welcome.


% 1) Inputs (have to be in this order)
% Required: - matrix to be saved as a tex table
%           - file title (= will be name of .tex file)
% Optional: - output directory; if blank, save to current directory
%           - table caption; if blank, will be current datetime
%           - table label; if blank, will be current datetime
%           - cell vector with column labels; if blank, will be col1-colN
%           - cell vector with row labels; if blank, will be row1-rowN

% 2) Output directory 
% I recommend to point the output directory to the folder with the main 
% tex file and to include the generated table using: \input{TABLE.tex}
% [Consider setting the output directory as global and adjust the code]

% 3) Column alignment
% By default, the content of the first column (= row labels) aligns left
% while all other columns center their content
% [Can be changed easily below (sec II) or in the generated tex file]


% Fun will now commence


%% I Check and prepare input

% Required inputs

% Is matrix provided?
test_mat = isempty(mat);
if test_mat == 1
    e_mat = 'Matrix is empty. No table created!';
    error(e_mat);
else
end

% Is title provided?
test_title = isempty(title);
if test_title == 1
    e_title = 'Title (= name of table tex file) not specified. No table created!';
    error(e_title);
else
end

% Optional inputs

% Use current directory for output if none provided
if ~exist('out_dir','var') || isempty(out_dir)
    out_dir = cd;
else
end

% Use datetime for caption if none provided
if ~exist('caption','var') || isempty(caption)
    caption = datestr(datetime('now'));
    caption = strrep(caption,' ','\_');
    caption = strrep(caption,':','\_');
    caption = strrep(caption,'-','\_');
else
    caption = strrep(caption,'_','\_');
end

% Use datetime for label if none provided
if ~exist('label','var') || isempty(label)
    label = datestr(datetime('now'));
    label = strrep(label,' ','_');
    label = strrep(label,':','_');
    label = strrep(label,'-','_');
else
end

% If colum labels provided, do they match matrix dimension?
if exist('col_labels','var')
    n_c_labels = numel(col_labels);
    if      n_c_labels>0 && n_c_labels < size(mat,2)
            e_col1 = 'Additional column labels required. No table created!';
            error(e_col1);
    elseif  n_c_labels>0 && n_c_labels > size(mat,2)
            e_col2 = 'Too many column labels specified. No table created!';
            error(e_col2);
    else
    end
% If column labels not provided, create generic ones    
else
        mat_c_vec = num2str(1:size(mat,2));
        mat_c_vec = strsplit(mat_c_vec);
        col_labels = strcat('col',mat_c_vec);
end

% If row labels provided, do they match matrix dimensions?
if exist('row_labels','var')
    n_r_labels = numel(row_labels);
    if      n_r_labels>0 && n_r_labels < size(mat,1)
            e_row1 = 'Additional row labels required. No table created!';
            error(e_row1);
    elseif  n_r_labels>0 && n_r_labels > size(mat,1)
            e_row2 = 'Too many row labels specified. No table created!';
            error(e_row2);
    else
    end 
% If row labels not provided, create generic ones 
else
        mat_r_vec = num2str(1:size(mat,1));
        mat_r_vec = strsplit(mat_r_vec);
        row_labels = strcat('row',mat_r_vec);
end

%% II Prepare table elements

% 1) Alignments
center = repmat(' c ',1,size(mat,2));
c1 = {'\\begin{tabular}{ l '};
cN = {'} \\hline  \n'};
falign = strcat(c1,center,cN);

% 2) First row
f_r_center = repmat(' & \\textbf{ %s } ',1,size(mat,2));
f_rN = ' \\\\ \\hline  \n';
fSpec_r1 = strcat(f_r_center,f_rN);

% 3) All other rows
r_center = repmat(' & %.0f ',1,size(mat,2));
r1 = ' %s ';
rN = ' \\\\  \n';
fSpec_r = strcat(r1,r_center,rN);

%% III Assemble elements and loop over rows of table

fileID = fopen([out_dir '/' title,'.tex'],'w');
fprintf(fileID,'\\begin{table}[h!] \n');
fprintf(fileID,'\\begin{center} \n');
fprintf(fileID,char(falign));

for i = 1:size(mat,1)+1
    if  i == 1
        fprintf(fileID,fSpec_r1,string(col_labels));
    else
        ii = i-1;
        fprintf(fileID,fSpec_r,char(row_labels(ii)),mat(ii,:));
    end
end

fprintf(fileID,'\\hline \\hline  \n');
fprintf(fileID,'\\end{tabular}  \n');
fprintf(fileID,'\\end{center}  \n');
fprintf(fileID,'\\caption{ %s } \n',char(caption));
fprintf(fileID,'\\label{ %s } \n',char(label));
fprintf(fileID,'\\end{table}  \n');
fclose(fileID);

end

