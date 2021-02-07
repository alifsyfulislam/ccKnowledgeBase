<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class QuizForm extends Model
{

    /**
     * @var string[]
     */
    protected $fillable = ['id', 'name', 'slug'];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function quizFormField()
    {

        return $this->hasMany(QuizFormField::class);

    }

    /**
     * @param $date
     * @return string
     */
    public function getCreatedAtAttribute($date)
    {

        return date('j M, Y', strtotime($date));

    }

    /**
     * @param $date
     * @return string
     */
    public function getUpdatedAtAttribute($date)
    {

        return date('j M, Y', strtotime($date));

    }
}
