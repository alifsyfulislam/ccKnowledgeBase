<?php

namespace App\Models;

//use Illuminate\Database\Eloquent\Model;
use Jenssegers\Mongodb\Eloquent\Model;

class Media extends Model
{
    protected $collection = 'media';
    protected $primaryKey = 'id';
    /**
     * @var string[]
     */
    protected $fillable = ['url'];


    /**
     * @return MorphTo
     */
    public function Mediable()
    {

        return $this->morphTo();

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
