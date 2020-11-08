<?php

namespace App\Http\Middleware;

use Closure;

class AclMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next, $role, $permission = null)
    {
        if(!$request->user()->hasRole($role)) {


            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);

        }

        if($permission !== null && !$request->user()->can($permission)) {

            return response()->json(['status_code' => 424, 'messages'=>'User does not have the right permissions']);
        }

        return $next($request);

    }
}
