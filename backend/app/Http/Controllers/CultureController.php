<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Culture;


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
        $culture->delete();
        return response()->json($culture);
    }

}
