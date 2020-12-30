<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class Media extends Model
{
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

    public function getCreatedAtAttribute($date)
    {
        return Carbon::createFromFormat('Y-m-d H:i:s', $date)->format("j M, Y");
    }

    public function getUpdatedAtAttribute($date)
    {
        return Carbon::createFromFormat('Y-m-d H:i:s', $date)->format("j M, Y");
    }

}
