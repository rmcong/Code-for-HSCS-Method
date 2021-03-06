% Function to turn per-frame superpixel labels into unique per-shot labels
%
%    Copyright (C) 2013  Anestis Papazoglou
%
%    You can redistribute and/or modify this software for non-commercial use
%    under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%    For commercial use, contact the author for licensing options.
%
%    Contact: a.papazoglou@sms.ed.ac.uk

function [ output, superpixelFrameIDs, frameSuperpixelBounds, globalIDs ] = ...
    makeSuperpixelIndexUnique( group_sup_info )

Imgnum = length(group_sup_info);
output = cell( Imgnum,1 );

globalIDs = 0;
frameSuperpixelBounds = [ 1 ];
for( frame = 1: Imgnum )
    Label = group_sup_info(frame).label;
    indexes = max( Label(:) );
    output{ frame } = globalIDs +  Label;
    globalIDs = globalIDs + indexes;
    frameSuperpixelBounds( frame + 1 ) = globalIDs + 1;
end
globalIDs = double( globalIDs );

superpixelFrameIDs = zeros( globalIDs, 1 );
for( frame = 1: Imgnum )
    superpixelFrameIDs( frameSuperpixelBounds( frame ):frameSuperpixelBounds( frame + 1 ) - 1 ) = frame;
end

end

