<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class QuizFormField extends Model
{
    protected $table = 'quiz_form_fields';

    protected $fillable = ["quiz_form_id", "f_label", "f_name", "f_id", "f_class", "f_type", "f_option_value", "f_default_value",
        "f_max_value", "f_sort_order", "f_required",];

    public function quizForm(){

        return $this->belongsToMany(QuizForm::class);

    }

    public function getCreatedAtAttribute($date)
    {
        return Carbon::createFromFormat('Y-m-d H:i:s', $date)->format("j M, Y");
    }

    public function getUpdatedAtAttribute($date)
    {
        return Carbon::createFromFormat('Y-m-d H:i:s', $date)->format("j M, Y");
    }
}
