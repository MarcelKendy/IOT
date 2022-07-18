<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Culture;
class Batch extends Model
{
    use HasFactory;
    public function culture()
    {
        return $this->belongsTo(Culture::class);

    }
}
