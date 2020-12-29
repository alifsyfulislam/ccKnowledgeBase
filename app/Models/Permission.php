<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class Permission extends Model
{

    protected $fillable = ['name', 'slug'];

    public function roles()
    {

        return $this->belongsToMany(Role::class,'roles_permissions');

    }

    public function users()
    {

        return $this->belongsToMany(User::class,'users_permissions', 'user_id');

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
