function [] = Ilastik_image_write(tif_name,image_3dmatrix)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

t = Tiff(tif_name,'w');

fiji_descr = ['ImageJ=1.52p' newline ...
    'images=' num2str(size(image_3dmatrix,3)*...
    size(image_3dmatrix,4)*...
    size(image_3dmatrix,5)) newline...
    'channels=' num2str(size(image_3dmatrix,3)) newline...
    'slices=' num2str(size(image_3dmatrix,4)) newline...
    'frames=' num2str(size(image_3dmatrix,5)) newline...
    'hyperstack=true' newline...
    'mode=grayscale' newline...
    'loop=false' newline...
    'min=0.0' newline...
    'max=' max(max(max(image_3dmatrix)))];

tagstruct.ImageDescription = fiji_descr;
tagstruct.ImageLength = size(image_3dmatrix,1);
tagstruct.ImageWidth = size(image_3dmatrix,2);
tagstruct.BitsPerSample = 16;
tagstruct.SampleFormat = 1; % uint
tagstruct.Photometric = Tiff.Photometric.LinearRaw;
tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky;
tagstruct.Software = 'MATLAB';

for ii=1:size(image_3dmatrix,3)
    setTag(t,tagstruct);
    write(t,image_3dmatrix(:,:,ii));
    writeDirectory(t);
end
close(t)
end
