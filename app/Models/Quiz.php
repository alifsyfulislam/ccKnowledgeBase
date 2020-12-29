<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class Quiz extends Model
{
    protected $table = 'quizzes';

    protected $fillable = [ "quiz_form_id", "name", "slug", "duration",
        "total_marks", "number_of_questions", "status"];

    public function quizForm(){

        return $this->belongsTo(QuizForm::class);

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
