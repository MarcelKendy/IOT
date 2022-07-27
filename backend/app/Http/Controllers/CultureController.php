<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Culture;
use App\Models\Batch;


class CultureController extends Controller
{

    public function getCultures(Request $request)
    {
        $all_data = Culture::all();
     
        return response()->json($all_data);
    }
   
    public function addCulture(Request $request)
    {
        $newData = new Culture();
        $newData->name = $request->name;
        $newData->soil_moisture = $request->soil_moisture;
        $newData->save();
        return response()->json($newData);
    }

    public function editCulture(Culture $culture, Request $request)
    {
        $culture->name = $request->name;
        $culture->soil_moisture = $request->soil_moisture;
        $culture->save();
        return response()->json($culture);
    }

    public function deleteCulture(Culture $culture, Request $request)
    {
        $batches = count(Batch::where('culture_id', $culture->id)->limit(1)->get()->toArray());
        if ($batches > 0) {
            return 404;
        }
        $culture->delete();
        return response()->json($culture);
    }

}
