function generate_bval_file(bvals, bvalues_filename)
    % write bvals into file
    [fid,msg] = fopen(bvalues_filename,'wt');
    assert(fid>=3,msg);
    fprintf(fid,'%.02f ', bvals);
    fclose(fid);
end