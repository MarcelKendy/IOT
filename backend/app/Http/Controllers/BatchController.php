<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Batch;


class BatchController extends Controller
{

    public function getBatches(Request $request)
    {
        $all_data = Batch::with('culture')->get();

        return response()->json($all_data);
    }

    public function addBatch(Request $request)
    {
        $newData = new Batch();
        $newData->name = $request->name;
        $newData->culture_id = $request->culture_id;
        $newData->location = $request->location;
        $newData->current_soil_moisture = 0;
        $newData->save();
        return response()->json($newData->load('culture'));
    }

    public function editBatch(Batch $batch, Request $request)
    {
        $batch->name = $request->name;
        $batch->location = $request->location;
        if ($batch->culture_id !== $request->culture_id) {
            $batch->current_soil_moisture = 0;
        }
        $batch->culture_id = $request->culture_id;
        $batch->save();
        return response()->json($batch->load('culture'));
    }

    public function deleteBatch(Batch $batch, Request $request)
    {
        $batch->delete();
        return response()->json($batch);
    }
}
