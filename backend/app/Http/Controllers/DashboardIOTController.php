<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Batch;
use App\Models\Parameter;


class DashboardIOTController extends Controller
{
    public function getBarChart(Request $request)
    {
        $all_batches = Batch::with('culture')->get();
     
        return response()->json($all_batches);
    }
    public function getBatches(Request $request)
    {
        $all_batches = Batch::with('culture')->get();
     
        return response()->json($all_batches);
    }
    public function getParameters(Request $request)
    {
        $all_parameters = Parameter::first();
     
        return response()->json($all_parameters);
    }

    public function editMoisture(Batch $batch, Request $request) {
        $batch->current_soil_moisture = $request->current_soil_moisture;
        $batch->save();
        return true;
    }
    
    public function resetMoisture(Request $request) {
        Batch::query()->update(['current_soil_moisture' => 0]);
        return true;
    }
}
