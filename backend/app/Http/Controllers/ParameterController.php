<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Parameter;


class ParameterController extends Controller
{

    public function getParameters(Request $request)
    {
        $all_data = Parameter::first();
     
        return response()->json($all_data);
    }

    public function editParameter(Parameter $parameter, Request $request)
    {   
        $parameter->time_in_seconds = number_format((float)$request->time_in_seconds, 2, '.', '');
        $parameter->moisture_increase = number_format((float)$request->moisture_increase, 2, '.', '');
        $parameter->save();
        return response()->json($parameter);
    }
   

}
