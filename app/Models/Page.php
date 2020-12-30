<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class Page extends Model
{
    protected $table   = 'pages';
    protected $guarded = ['created_at', 'updated_at'];

    public function media()
    {
        return $this->morphOne(Media::class, 'mediable');
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
