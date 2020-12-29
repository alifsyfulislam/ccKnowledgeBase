<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class QuizForm extends Model
{
    protected $fillable = ['id', 'name', 'slug'];

    public function quizFormField(){
        return $this->hasMany(QuizFormField::class);
    }

    public function getCreatedAtAttribute($date)
    {
        return Carbon::createFromFormat('Y-m-d H:i:s', $date)->format("F j, Y, g:i a");
    }

    public function getUpdatedAtAttribute($date)
    {
        return Carbon::createFromFormat('Y-m-d H:i:s', $date)->format("F j, Y, g:i a");
    }
}
