<?php

namespace App\Http\Traits;

use Illuminate\Http\Request;

trait QueryTrait
{
    protected static function likeQueryFilter($request, $query, array $likeFilterList)
    {
        foreach ($likeFilterList as $likeFilter)
        {
            if ($request->filled($likeFilter)) {
                $query->where($likeFilter, 'like', '%' . $request->{$likeFilter} . '%');
            }
        }

        return $query;
    }

    protected static function whereQueryFilter($request, $query, array $whereFilterList)
    {
        foreach ($whereFilterList as $whereFilter)
        {
            if ($request->filled($whereFilter)) {
                $query->where($whereFilter, $request->{$whereFilter});
            }
        }
        return $query;
    }

    protected static function filterDateBetween($request, $query, $column='created_at')
    {
        if($request->filled('from_date')){
            $query->whereDate($column, '>=', $request->from_date);
        }
        if($request->filled('to_date')){
            $query->whereDate($column, '<=', $request->to_date);
        }

        return $query;
    }

    protected static function filterWhereHasRelation($query, $request, $relation, $column)
    {
        if(!$request->{$column})
            return $query;

        return $query->whereHas($relation, function ($q) use ($request, $column) {
            $q->where($column, $request->{$column});
        });
    }

    protected static function filterUserMobileNo($query, $mobileNo=null, $relation=null)
    {
        if(!$mobileNo)
            return $query;

        if($relation)
            return $query->whereHas($relation, function ($q) use ($mobileNo) {
                $q->where('mobile_number', $mobileNo);
            });

        return $query->where('mobile_number', $mobileNo);
    }


    /*protected static function filterUserMobileNo($query, $mobileNo=null, $relation=null)
    {
        if(!$mobileNo)
            return $query;

        $refinedMobileNo = "+88".substr($mobileNo, -11);

        if($relation)
            return $query->whereHas($relation, function ($q) use ($refinedMobileNo) {
                $q->where('mobile_number', $refinedMobileNo);
            });

        return $query->where('mobile_number', $refinedMobileNo);
    }*/

    protected static function filterUserName($query, $name=null, $relation=null)
    {
        if(!$name)
            return $query;

        if($relation)
            return $query->whereHas($relation, function ($q) use ($name) {
                $q->where('name', 'like',  '%' .$name. '%');
            });
        return $query;

    }
}
