function DrawEntityBoundingBox(entity,r,g,b,a)
  local box = GetEntityBoundingBox(entity)
  DrawBoundingBox(box,r,g,b,a)
end

function GetEntityBoundingBox(entity)
  local min,max = GetModelDimensions(GetEntityModel(entity))
  local pad = 0.001

  return {
    [1] = GetOffsetFromEntityInWorldCoords(entity, min.x - pad, min.y - pad, min.z - pad),
    [2] = GetOffsetFromEntityInWorldCoords(entity, max.x + pad, min.y - pad, min.z - pad),
    [3] = GetOffsetFromEntityInWorldCoords(entity, max.x + pad, max.y + pad, min.z - pad),
    [4] = GetOffsetFromEntityInWorldCoords(entity, min.x - pad, max.y + pad, min.z - pad),

    [5] = GetOffsetFromEntityInWorldCoords(entity, min.x - pad, min.y - pad, max.z + pad),
    [6] = GetOffsetFromEntityInWorldCoords(entity, max.x + pad, min.y - pad, max.z + pad),
    [7] = GetOffsetFromEntityInWorldCoords(entity, max.x + pad, max.y + pad, max.z + pad),
    [8] = GetOffsetFromEntityInWorldCoords(entity, min.x - pad, max.y + pad, max.z + pad),
  }
end

function DrawBoundingBox(box,r,g,b,a)
  local polyMatrix = GetBoundingBoxPolyMatrix(box)
  local edgeMatrix = GetBoundingBoxEdgeMatrix(box)

  DrawPolyMatrix(polyMatrix,r,g,b,a)
  DrawEdgeMatrix(edgeMatrix,255,255,255,255)
end

function GetBoundingBoxPolyMatrix(box)
   return {
    [1]  = {[1] = box[3],  [2] = box[2],  [3] = box[1]},
    [2]  = {[1] = box[4],  [2] = box[3],  [3] = box[1]},

    [3]  = {[1] = box[5],  [2] = box[6],  [3] = box[7]},
    [4]  = {[1] = box[5],  [2] = box[7],  [3] = box[8]},

    [5]  = {[1] = box[3],  [2] = box[4],  [3] = box[7]},
    [6]  = {[1] = box[8],  [2] = box[7],  [3] = box[4]},

    [7]  = {[1] = box[1],  [2] = box[2],  [3] = box[5]},
    [8]  = {[1] = box[6],  [2] = box[5],  [3] = box[2]},

    [9]  = {[1] = box[2],  [2] = box[3],  [3] = box[6]},
    [10] = {[1] = box[3],  [2] = box[7],  [3] = box[6]},

    [11] = {[1] = box[5],  [2] = box[8],  [3] = box[4]},
    [12] = {[1] = box[5],  [2] = box[4],  [3] = box[1]},
   }
end

function GetBoundingBoxEdgeMatrix(box)
   return {
    [1]  = {[1] = box[1], [2] = box[2]},
    [2]  = {[1] = box[2], [2] = box[3]},
    [3]  = {[1] = box[3], [2] = box[4]},
    [4]  = {[1] = box[4], [2] = box[1]},

    [5]  = {[1] = box[5], [2] = box[6]},
    [6]  = {[1] = box[6], [2] = box[7]},
    [7]  = {[1] = box[7], [2] = box[8]},
    [8]  = {[1] = box[8], [2] = box[5]},

    [9]  = {[1] = box[1], [2] = box[5]},
    [10] = {[1] = box[2], [2] = box[6]},
    [11] = {[1] = box[3], [2] = box[7]},
    [12] = {[1] = box[4], [2] = box[8]},
   }
end

function DrawPolyMatrix(polyCollection,r,g,b,a)
  for k=1,#polyCollection,1 do
    local v = polyCollection[k]
    DrawPoly(v[1].x,v[1].y,v[1].z, v[2].x,v[2].y,v[2].z, v[3].x,v[3].y,v[3].z, r,g,b,a)
  end
end

function DrawEdgeMatrix(linesCollection,r,g,b,a)
  for k=1,#linesCollection,1 do
    local v = linesCollection[k]
    DrawLine(v[1].x,v[1].y,v[1].z, v[2].x,v[2].y,v[2].z, r,g,b,a)
  end
end