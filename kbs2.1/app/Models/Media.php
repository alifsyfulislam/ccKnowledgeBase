<?php

namespace App\Models;

<<<<<<< HEAD
use Illuminate\Database\Eloquent\Model;
=======
//use Illuminate\Database\Eloquent\Model;
use Jenssegers\Mongodb\Eloquent\Model;
>>>>>>> 87a329c1058e3f6a35fe686d57319004d7190965

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
